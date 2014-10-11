package com.game.prenotice.model
{
    import com.f1.manager.*;
    import flash.utils.*;

    public class PrenoticeCfgObj extends Object
    {
        private var _taskEventDic:Dictionary;
        private var _lvEventDic:Dictionary;
        private var _gotoDic:Dictionary;
        private var _cfg:Object;
        private static var instance:PrenoticeCfgObj;

        public function PrenoticeCfgObj()
        {
            this._cfg = CfgManager.getInstance().getMap("q_function_foreshow");
            this.initCfg();
            return;
        }// end function

        private function initCfg() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._taskEventDic = new Dictionary();
            this._lvEventDic = new Dictionary();
            this._gotoDic = new Dictionary();
            for each (_loc_1 in this._cfg)
            {
                
                _loc_2 = _loc_1.q_requirement;
                _loc_3 = _loc_2.split("_");
                if (_loc_3 && _loc_3.length)
                {
                    if (_loc_3[0] == "1")
                    {
                        this._taskEventDic[_loc_3[1]] = _loc_1;
                    }
                    else if (_loc_3[0] == "2")
                    {
                        this._lvEventDic[_loc_3[1]] = _loc_1;
                    }
                    this._gotoDic[_loc_1.q_goto] = _loc_1;
                }
            }
            return;
        }// end function

        public function getCfgByGoto(param1:int) : Object
        {
            return this._gotoDic[param1];
        }// end function

        public function getCfgByIndex(param1:int) : Object
        {
            return this._cfg[param1];
        }// end function

        public function getCfgByTaskId(param1:int) : Object
        {
            return this._taskEventDic[param1];
        }// end function

        public function getCfgByLv(param1:int) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = [];
            for (_loc_2 in this._lvEventDic)
            {
                
                if (int(_loc_2) <= param1)
                {
                    _loc_3.push(_loc_5[int(_loc_2)]);
                }
            }
            return _loc_3;
        }// end function

        public static function getInstance() : PrenoticeCfgObj
        {
            if (instance == null)
            {
                instance = new PrenoticeCfgObj;
            }
            return instance;
        }// end function

    }
}
