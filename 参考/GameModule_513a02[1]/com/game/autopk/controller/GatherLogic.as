package com.game.autopk.controller
{
    import com.f1.*;
    import com.game.autopk.model.*;
    import com.game.gather.control.*;
    import com.game.map.model.*;
    import com.game.role.model.*;
    import com.model.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class GatherLogic extends EventDispatcher
    {
        private var _mapId:int;
        private var _coord:Point;
        private var startTime:int;
        private var timeCounter:int;
        private var _fighting:Boolean;
        private var lastClickGather:int;
        private var lastClickTime:int;
        public static const CHECK_TIME_GAP:int = 250;

        public function GatherLogic()
        {
            return;
        }// end function

        public function get mapId() : int
        {
            return this._mapId;
        }// end function

        public function get coord() : Point
        {
            return this._coord;
        }// end function

        public function get fighting() : Boolean
        {
            return this._fighting;
        }// end function

        public function gather(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._fighting = param1;
            if (param1)
            {
                this.startTime = getTimer();
                _loc_2 = RoleList.getInstance().player;
                this._mapId = MapObj.getInstance().mapID;
                this._coord = new Point(_loc_2._x, _loc_2._y);
                FrameworkGlobal.addMsgListen("gatherEnd", this._gatherEnd);
                if (!GatherController.getInstance().isGathering)
                {
                    this._moveToGather();
                }
                this.auto = true;
            }
            else
            {
                this.finalize();
            }
            return;
        }// end function

        private function _moveToGather() : void
        {
            var _loc_2:* = null;
            if (GatherController.getInstance().isGathering)
            {
                return;
            }
            if (this.lastClickGather != 0 && getTimer() - this.lastClickTime < 2000)
            {
                return;
            }
            this.lastClickTime = getTimer();
            var _loc_1:* = NpcList.getInstance().getNearestNpcByCfgId(AutoFightModel.mounsterType);
            if (_loc_1)
            {
                this.lastClickGather = _loc_1.info.cfgId;
                _loc_2 = new MouseEvent(MouseEvent.CLICK, true, false);
                _loc_1.dispatchEvt(_loc_2);
            }
            else
            {
                this.patrol();
            }
            return;
        }// end function

        private function _gatherEnd(event:Event) : void
        {
            this.lastClickGather = 0;
            this._moveToGather();
            return;
        }// end function

        private function patrol() : void
        {
            if (GatherController.getInstance().isGathering)
            {
                return;
            }
            if (getTimer() - this.startTime < 3000)
            {
                return;
            }
            var _loc_1:* = RoleList.getInstance();
            var _loc_2:* = _loc_1.player;
            var _loc_3:* = FrameworkGlobal.stageH * 0.5;
            if (_loc_2.isPathing)
            {
                return;
            }
            if (AutoFightModel.fightRange != 1)
            {
                _loc_2.pathByCoo(_loc_2._x + Math.random() * _loc_3, _loc_2._y + Math.random() * _loc_3, 0, 0, false, false);
            }
            else
            {
                _loc_2.pathByCoo(this.coord.x + Math.random() * _loc_3, this.coord.y + Math.random() * _loc_3, 0, 0, false, false);
            }
            return;
        }// end function

        private function onFrameHandle(event:Event) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this.timeCounter < CHECK_TIME_GAP)
            {
                return;
            }
            this.timeCounter = _loc_2;
            this._moveToGather();
            return;
        }// end function

        private function set auto(param1:Boolean) : void
        {
            if (param1)
            {
                FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.onFrameHandle);
            }
            else
            {
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.onFrameHandle);
            }
            return;
        }// end function

        private function finalize() : void
        {
            FrameworkGlobal.removeMsgListen("gatherEnd", this._gatherEnd);
            NpcData.getInstance().selectNpc = null;
            this.lastClickGather = 0;
            this.auto = false;
            return;
        }// end function

    }
}
