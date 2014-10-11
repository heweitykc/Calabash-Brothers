package com.game.activitiesoverview.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.activitiesoverview.protocol.*;
    import com.game.activitiesoverview.view.*;
    import com.game.casting.control.*;
    import com.game.equipstreng.control.*;
    import com.game.goldRaffle.control.*;
    import com.game.mall.control.*;
    import com.game.mall.model.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.prey.control.*;
    import com.game.redfortress.control.*;
    import com.game.signwage.control.*;
    import com.game.signwage.event.*;
    import com.game.task.control.*;
    import com.game.vip.control.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.model.vo.*;

    public class ActivitiesOverviewControl extends Object
    {
        private var _protocol:ActivitiesOverviewProtocol;
        private var _activitiesoverview:ActivitiesOverview;
        private var _boxesState:Object;
        private var _eventsState:Object;
        private var _liveness:int;
        private static var _inst:ActivitiesOverviewControl;

        public function ActivitiesOverviewControl()
        {
            this._protocol = new ActivitiesOverviewProtocol();
            this._boxesState = new Object();
            this._eventsState = new Object();
            return;
        }// end function

        public function get activitiesoverview() : ActivitiesOverview
        {
            return this._activitiesoverview;
        }// end function

        public function set activitiesoverview(param1:ActivitiesOverview) : void
        {
            this._activitiesoverview = param1;
            return;
        }// end function

        public function getBoxState(param1:int) : int
        {
            if (this._boxesState[param1])
            {
                return this._boxesState[param1];
            }
            return 0;
        }// end function

        public function hasBoxCanGain() : int
        {
            var _loc_3:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < 4)
            {
                
                _loc_3 = LivenessBoxCfgObj.getInstance().getBoxById((_loc_2 + 1));
                if (this._boxesState[(_loc_2 + 1)] != 1)
                {
                    if (_loc_3.condition <= this._liveness)
                    {
                        _loc_1++;
                    }
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function getEventCout(param1:int) : int
        {
            if (this._eventsState[param1])
            {
                return this._eventsState[param1];
            }
            return 0;
        }// end function

        public function gainBoxesRes(param1:Vector.<RewardBoxInfo>) : void
        {
            this._boxesState = new Object();
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (param1[_loc_3].state == 1)
                {
                    this._boxesState[param1[_loc_3].id] = 1;
                }
                _loc_3++;
            }
            if (this._activitiesoverview)
            {
                this._activitiesoverview.updateBox();
            }
            SignWageControl.getInstance().dispatchEvt(new SignEvent(SignEvent.NUM_CHANGE));
            return;
        }// end function

        public function getEventRes(param1:Vector.<LivenessEventInfo>) : void
        {
            this._eventsState = new Object();
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                this._eventsState[param1[_loc_3].type] = param1[_loc_3].count;
                _loc_3++;
            }
            if (this._activitiesoverview)
            {
                this._activitiesoverview.updateEvent();
            }
            return;
        }// end function

        public function gainBoxRes(param1:int, param2:int) : void
        {
            if (param2 != 1)
            {
                this._boxesState[param1] = 1;
                this._activitiesoverview.gainBoxSuc((param1 - 1));
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10192"));
                SignWageControl.getInstance().dispatchEvt(new SignEvent(SignEvent.NUM_CHANGE));
            }
            return;
        }// end function

        public function setLiveness(param1:int) : void
        {
            this._liveness = param1;
            if (this._activitiesoverview)
            {
                this._activitiesoverview.liveness = param1;
            }
            SignWageControl.getInstance().dispatchEvt(new SignEvent(SignEvent.NUM_CHANGE));
            return;
        }// end function

        public function gainBox(param1:int) : void
        {
            this._protocol.gainBox(param1);
            return;
        }// end function

        public function changeEvent(param1:int, param2:int) : void
        {
            if (!this._eventsState)
            {
                return;
            }
            this._eventsState[param1] = param2;
            if (this._activitiesoverview)
            {
                this._activitiesoverview.updateItem(param1, param2);
                this._activitiesoverview.updateEvent();
            }
            return;
        }// end function

        public function reqEvent() : void
        {
            this._protocol.reqEvent();
            return;
        }// end function

        public function reqliveness() : void
        {
            this._protocol.reqliveness();
            return;
        }// end function

        public function reqBox() : void
        {
            this._protocol.reqBox();
            return;
        }// end function

        public function getView() : ActivitiesOverview
        {
            if (this._activitiesoverview == null)
            {
                this._activitiesoverview = new ActivitiesOverview();
            }
            return this._activitiesoverview;
        }// end function

        public function doAssignment(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            switch(param1)
            {
                case 1:
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10193"));
                    break;
                }
                case 2:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                case 3:
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10193"));
                    break;
                }
                case 4:
                {
                    ZonesControl.getInstance().openZonesBeliaWorld();
                    break;
                }
                case 5:
                {
                    ZonesControl.getInstance().openZonesScarletHold();
                    break;
                }
                case 6:
                {
                    _loc_2 = MapCfgObj.getInstance().getAllRecommandMonListByMap(UserObj.getInstance().playerInfo.level, MapObj.getInstance().mapID);
                    if (_loc_2 != null && _loc_2.length > 0)
                    {
                        _loc_3 = _loc_2[0];
                    }
                    else
                    {
                        _loc_2 = MapCfgObj.getInstance().getAllRecommandMonListByFormula();
                        if (_loc_2 != null && _loc_2.length > 0)
                        {
                            _loc_3 = _loc_2[0];
                        }
                    }
                    if (_loc_3)
                    {
                        MapControl.getInstance().trans(_loc_3.monMapId, _loc_3.monX, _loc_3.monY);
                    }
                    break;
                }
                case 7:
                {
                    TaskControl.getInstance().openOrClose(1);
                    break;
                }
                case 8:
                {
                    ZhuZaoControl.getInstance().openZhuZaoPanel();
                    break;
                }
                case 9:
                {
                    MallControl.getInstance().openMall(MallModel.BINDDIAMOND);
                    break;
                }
                case 10:
                {
                    GoldRaffleControl.getInstance().openRafflesOrClosePanel();
                    break;
                }
                case 11:
                {
                    PrayControl.getInstance().openOrClosePrayBox();
                    break;
                }
                case 12:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox(1);
                    break;
                }
                case 13:
                {
                    ZonesRedFortressControl.getInstance().openOrCloseRedFortressPanel();
                    break;
                }
                case 14:
                {
                    ZonesControl.getInstance().openZonesDekaron();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : ActivitiesOverviewControl
        {
            var _loc_1:* = new ActivitiesOverviewControl;
            _inst = new ActivitiesOverviewControl;
            return _inst || _loc_1;
        }// end function

    }
}
