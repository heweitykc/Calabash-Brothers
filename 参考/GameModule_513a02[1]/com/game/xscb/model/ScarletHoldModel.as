package com.game.xscb.model
{
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import flash.geom.*;

    public class ScarletHoldModel extends Object
    {
        private var _phases:Array;
        private var _curPhase:int;
        private var _zoneInfo:ZonesTableVo;
        private var _zoneid:int;
        private var _task:Array;
        private var _specialTask:Object;
        private static var _inst:ScarletHoldModel;

        public function ScarletHoldModel()
        {
            this._phases = [];
            this._task = [{phase:0, describe:LanguageCfgObj.getInstance().getByIndex("12314"), target:30, type:2}, {phase:1, describe:LanguageCfgObj.getInstance().getByIndex("12315"), target:1, type:1}, {phase:1, describe:LanguageCfgObj.getInstance().getByIndex("12316"), target:10, type:2}, {phase:2, describe:LanguageCfgObj.getInstance().getByIndex("12317"), target:1, type:1}, {phase:3, describe:LanguageCfgObj.getInstance().getByIndex("12318"), target:1, type:1}, {phase:4, describe:LanguageCfgObj.getInstance().getByIndex("12319"), target:1, type:1}, {phase:5, describe:LanguageCfgObj.getInstance().getByIndex("12320"), target:1, type:1}, {phase:6, describe:LanguageCfgObj.getInstance().getByIndex("12321"), target:1, value:1, type:1}];
            this._specialTask = {phase:0, describe:LanguageCfgObj.getInstance().getByIndex("12322"), target:40};
            var _loc_1:* = new Object();
            _loc_1.line = [new Point(81, 101), new Point(85, 105)];
            _loc_1.ang = ToolKit.getAngle(_loc_1.line[1].x, _loc_1.line[1].y, _loc_1.line[0].x, _loc_1.line[0].y);
            this._phases.push(_loc_1);
            _loc_1 = new Object();
            _loc_1.line = [new Point(137, 54), new Point(158, 66)];
            _loc_1.ang = ToolKit.getAngle(_loc_1.line[1].x, _loc_1.line[1].y, _loc_1.line[0].x, _loc_1.line[0].y);
            this._phases.push(_loc_1);
            return;
        }// end function

        public function get specialTask() : Object
        {
            return this._specialTask;
        }// end function

        public function set specialTask(param1:Object) : void
        {
            this._specialTask = param1;
            return;
        }// end function

        public function get zoneid() : int
        {
            return this._zoneid;
        }// end function

        public function set zoneid(param1:int) : void
        {
            this._zoneid = param1;
            return;
        }// end function

        public function get zoneInfo() : ZonesTableVo
        {
            return this._zoneInfo;
        }// end function

        public function set zoneInfo(param1:ZonesTableVo) : void
        {
            this._zoneInfo = param1;
            return;
        }// end function

        public function get task() : Array
        {
            return this._task;
        }// end function

        public function set task(param1:Array) : void
        {
            this._task = param1;
            return;
        }// end function

        public function get phases() : Array
        {
            return this._phases;
        }// end function

        public function set phases(param1:Array) : void
        {
            this._phases = param1;
            return;
        }// end function

        public function get curPhase() : int
        {
            return this._curPhase;
        }// end function

        public function set curPhase(param1:int) : void
        {
            this._curPhase = param1;
            return;
        }// end function

        public function getBasePoint(param1:int) : Point
        {
            if (param1 == 2)
            {
                param1 = 1;
            }
            return this._phases[param1].line[1];
        }// end function

        public function getLeftPoint(param1:int) : Point
        {
            if (param1 == 2)
            {
                param1 = 1;
            }
            return this._phases[param1].line[0];
        }// end function

        public function getSlope(param1:int) : int
        {
            if (param1 == 2)
            {
                param1 = 1;
            }
            return this._phases[param1].ang;
        }// end function

        public static function getInstance() : ScarletHoldModel
        {
            var _loc_1:* = new ScarletHoldModel;
            _inst = new ScarletHoldModel;
            return _inst || _loc_1;
        }// end function

    }
}
