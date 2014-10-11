package com.game.horse.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.horse.message.*;
    import com.game.horse.protocol.*;
    import com.game.horse.view.*;
    import com.game.primaryrole.control.*;
    import com.model.*;
    import com.model.vo.*;
    import interfaces.role.*;

    public class HorseControl extends Object
    {
        private var CDTime:uint = 0;
        private var _horseView:HorseView;
        private var _horseUpScanView:HorseUpScanView;
        private var _protocol:HorseProtocol;
        private static var _instance:HorseControl;

        public function HorseControl()
        {
            this._protocol = new HorseProtocol();
            return;
        }// end function

        public function initHorseView() : void
        {
            if (!this._horseView)
            {
                this._horseView = new HorseView();
                this._horseUpScanView = new HorseUpScanView();
                Global.popManager.addPop(this._horseUpScanView);
            }
            return;
        }// end function

        public function get horseView() : HorseView
        {
            return this._horseView;
        }// end function

        public function getHorseInfo(param1:int) : HorseInfo
        {
            var _loc_2:* = HorseCfgObj.getInstance().getInfoFromLevel(param1);
            return _loc_2;
        }// end function

        public function updatePanel() : void
        {
            this.reqGetHorseInfo();
            return;
        }// end function

        public function openHorseUpScan() : void
        {
            this._horseUpScanView.openOrClose();
            return;
        }// end function

        public function closeHorseUpScan() : void
        {
            this._horseUpScanView.close();
            return;
        }// end function

        public function changeRidingState() : void
        {
            if (this.CDTime > 0)
            {
                return;
            }
            var _loc_1:* = UserObj.getInstance().playerInfo.horseInfo;
            if (_loc_1)
            {
                this.reqChangeRidingState(_loc_1.horseStat, _loc_1.horse_level);
            }
            return;
        }// end function

        public function horseCulture(param1:int) : void
        {
            this.reqHorseStageUpStart(param1);
            return;
        }// end function

        public function addedToSystem(param1:String) : void
        {
            if (this.horseView)
            {
                this.horseView.addedToSystem(param1);
            }
            return;
        }// end function

        private function reqChangeRidingState(param1:int, param2:int) : void
        {
            this._protocol.reqChangeRidingState(param1, param2);
            return;
        }// end function

        private function reqGetHorseInfo() : void
        {
            this._protocol.reqGetHorseInfo();
            return;
        }// end function

        private function reqHorseStageUpStart(param1:int) : void
        {
            this._protocol.reqHorseStageUpStartMessage(param1);
            return;
        }// end function

        public function ResRidingStateHandler(param1:ResRidingStateMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.playerid);
            if (_loc_2)
            {
                _loc_2.info.horseInfo = HorseCfgObj.getInstance().getInfoFromLevel(param1.curlayer, _loc_2.info.horseInfo);
                _loc_2.info.horseInfo.horseStat = param1.status;
                if (_loc_2.updateAct())
                {
                    _loc_2.updateHorse();
                }
                if (_loc_2.isUser())
                {
                    _loc_2.info.dispatchEvent(new RoleEvent(RoleEvent.UPDATE_HORSE_STATE));
                    if (this._horseView)
                    {
                        this.horseView.setRideState(param1.status);
                    }
                }
            }
            return;
        }// end function

        public function resHorseInfoHandler(param1:ResHorseInfoMessage) : void
        {
            var _loc_2:* = UserObj.getInstance().playerInfo.horseInfo;
            _loc_2 = HorseCfgObj.getInstance().getInfoFromLevel(param1.horseinfo.curlayer, _loc_2);
            _loc_2.currentExp = param1.horseinfo.horseexp;
            _loc_2.horseStat = param1.horseinfo.status;
            UserObj.getInstance().playerInfo.horseInfo = _loc_2;
            var _loc_3:* = RoleList.getInstance().player;
            if (_loc_3)
            {
                if (_loc_3.updateAct())
                {
                    _loc_3.updateHorse();
                }
            }
            if (this._horseView)
            {
                this._horseView.updateHorseInfo(UserObj.getInstance().playerInfo.horseInfo);
            }
            PrimaryRoleControl.getInstance().initHorse();
            return;
        }// end function

        public function ReshorseStageUpResultHandler(param1:ReshorseStageUpResultMessage) : void
        {
            this.horseView.horseCultureBack(param1.curlayer);
            UserObj.getInstance().playerInfo.horseInfo = HorseCfgObj.getInstance().getInfoFromLevel(param1.curlayer, UserObj.getInstance().playerInfo.horseInfo);
            UserObj.getInstance().playerInfo.horseInfo.currentExp = param1.exp;
            this.horseView.updateHorseInfo(UserObj.getInstance().playerInfo.horseInfo);
            if (UserObj.getInstance().playerInfo.horseInfo.horse_step == 2 && GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().HORSE_UP_ACTIVE_TEAM)) != 1)
            {
                GuideControl.getInstance().guideItemClick(GuideConfigObj.getInstance().HORSE_UP_GUIDE_ID_2);
            }
            return;
        }// end function

        public function resHorseReceiveHandler(param1:ReshorseReceiveMessage) : void
        {
            if (RoleList.getInstance().player.info.horseInfo && RoleList.getInstance().player.info.horseInfo.horseStat == 0)
            {
                this.changeRidingState();
            }
            return;
        }// end function

        public function reqHorseReceive() : void
        {
            this._protocol.reqHorseReceive();
            return;
        }// end function

        public static function getInstance() : HorseControl
        {
            if (!_instance)
            {
                _instance = new HorseControl;
            }
            return _instance;
        }// end function

    }
}
