package com.game.gather.control
{
    import com.*;
    import com.f1.*;
    import com.game.country.control.*;
    import com.game.gather.model.*;
    import com.game.gather.view.*;
    import com.game.map.model.*;
    import com.game.npc.message.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.utils.*;

    public class GatherController extends Object
    {
        private var _isGathering:Boolean = false;
        private var _costtime:int = 3000;
        private var _startTime:int;
        private var _bar:GatherBar;
        private static var _instance:GatherController;

        public function GatherController()
        {
            return;
        }// end function

        public function set costtime(param1:int) : void
        {
            this._costtime = param1;
            return;
        }// end function

        public function gatherTaskStartHandle(param1:ResStartGatherMessage) : void
        {
            if (MapObj.getInstance().mapID == Params.COUNTRY_MAP_ID)
            {
                CountryControl.getInstance().startGather(param1.costtime);
                return;
            }
            this._costtime = param1.costtime;
            GatherModel.getInstance().total = this._costtime;
            GatherModel.getInstance().num = 0;
            this.start();
            return;
        }// end function

        private function add() : void
        {
            this._bar = GatherBar.getInstance();
            Global.popManager.addPop(this._bar, false, false, true, true, false, true);
            this._bar.open();
            if (this._bar.label)
            {
                this._bar.label.text = 0 + "/" + GatherModel.getInstance().total;
            }
            FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            this.isGathering = true;
            return;
        }// end function

        private function remove() : void
        {
            FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            this._bar = GatherBar.getInstance();
            this._bar.close();
            this.isGathering = false;
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:* = getTimer();
            var _loc_3:* = _loc_2 - this._startTime;
            if (_loc_3 > this._costtime)
            {
                if (this._bar.label)
                {
                    this._bar.label.text = GatherModel.getInstance().total + "/" + GatherModel.getInstance().total;
                }
                this.stop();
                FrameworkGlobal.sendMsg(new Event("gatherEnd"));
            }
            else
            {
                GatherBar.getInstance().progress = _loc_3 / this._costtime;
                if (this._bar.label)
                {
                    this._bar.label.text = int(_loc_3 / this._costtime * GatherModel.getInstance().total) + "/" + GatherModel.getInstance().total;
                }
            }
            return;
        }// end function

        public function start() : void
        {
            this._startTime = getTimer();
            this.add();
            return;
        }// end function

        public function purse() : void
        {
            var _loc_1:* = getTimer();
            var _loc_2:* = _loc_1 - this._startTime;
            this._costtime = this._costtime - _loc_2;
            FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            return;
        }// end function

        public function stop() : void
        {
            this.remove();
            return;
        }// end function

        public function get isGathering() : Boolean
        {
            return this._isGathering;
        }// end function

        public function set isGathering(param1:Boolean) : void
        {
            this._isGathering = param1;
            return;
        }// end function

        public static function getInstance() : GatherController
        {
            var _loc_1:* = new GatherController;
            _instance = new GatherController;
            return _instance || _loc_1;
        }// end function

    }
}
