package com.game.login.cfg
{
    import com.cfg.vo.*;
    import com.f1.manager.*;

    public class NameCfgObj extends Object
    {
        private var _maxKey:uint;
        private var _map:Object;
        private static var instance:NameCfgObj;

        public function NameCfgObj()
        {
            var _loc_1:* = null;
            this._map = CfgManager.getInstance().getMap("NameCfg");
            for (_loc_1 in this._map)
            {
                
                if (uint(_loc_1) > this._maxKey)
                {
                    this._maxKey = uint(_loc_1);
                }
            }
            var _loc_2:* = this;
            var _loc_3:* = this._maxKey - 1;
            _loc_2._maxKey = _loc_3;
            return;
        }// end function

        private function getRandCfg() : NameCfg
        {
            var _loc_1:* = int(Math.random() * this._maxKey) + 1;
            if (this._map[_loc_1] == null)
            {
                _loc_1 = int(Math.random() * this._maxKey) + 1;
            }
            var _loc_2:* = new NameCfg();
            _loc_2.parse(this._map[_loc_1]);
            return _loc_2;
        }// end function

        public function getRandName(param1:int) : String
        {
            var _loc_2:* = "";
            _loc_2 = _loc_2 + this.getRandCfg().FirstName;
            if (param1 == 1)
            {
                _loc_2 = _loc_2 + this.getRandCfg().SecondNameMale;
            }
            else
            {
                _loc_2 = _loc_2 + this.getRandCfg().SecondNameFemale;
            }
            return _loc_2;
        }// end function

        public static function getInstance() : NameCfgObj
        {
            if (instance == null)
            {
                instance = new NameCfgObj;
            }
            return instance;
        }// end function

    }
}
