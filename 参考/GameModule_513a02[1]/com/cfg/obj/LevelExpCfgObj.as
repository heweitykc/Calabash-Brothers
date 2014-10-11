package com.cfg.obj
{
    import com.f1.manager.*;
    import com.f1.utils.*;

    public class LevelExpCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:LevelExpCfgObj;

        public function LevelExpCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_character");
            return;
        }// end function

        public function getExpByLevel(param1:uint, param2:uint) : Number
        {
            var _loc_3:* = param1.toString() + ToolKit.add0(param2, 4);
            var _loc_4:* = this._map[_loc_3];
            if (this._map[_loc_3])
            {
                return _loc_4.q_exp;
            }
            return 0;
        }// end function

        public function getQ_ExpByLevel(param1:uint, param2:uint) : Number
        {
            var _loc_3:* = param1.toString() + ToolKit.add0(param2, 4);
            var _loc_4:* = this._map[_loc_3];
            if (this._map[_loc_3])
            {
                return _loc_4.q_exp;
            }
            return 0;
        }// end function

        public function getQ_remoney(param1:uint, param2:uint) : Number
        {
            var _loc_3:* = param1.toString() + ToolKit.add0(param2, 4);
            var _loc_4:* = this._map[_loc_3];
            if (this._map[_loc_3])
            {
                return _loc_4.q_remoney;
            }
            return 0;
        }// end function

        public function getQ_rexp(param1:uint, param2:uint) : Number
        {
            var _loc_3:* = param1.toString() + ToolKit.add0(param2, 4);
            var _loc_4:* = this._map[_loc_3];
            if (this._map[_loc_3])
            {
                return _loc_4.q_rexp;
            }
            return 0;
        }// end function

        public static function getInstance() : LevelExpCfgObj
        {
            if (instance == null)
            {
                instance = new LevelExpCfgObj;
            }
            return instance;
        }// end function

    }
}
