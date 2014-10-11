package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;

    public class QMagicbookLevelCfg extends Object
    {
        private var _map:Object;
        private static var _instance:QMagicbookLevelCfg;

        public function QMagicbookLevelCfg()
        {
            this._map = CfgManager.getInstance().getMap("q_magicbook_level");
            return;
        }// end function

        public function getMagicBookCfg(param1:int) : QMagicBookCfg
        {
            var _loc_2:* = new QMagicBookCfg();
            var _loc_3:* = this._map[param1];
            if (_loc_3)
            {
                _loc_2.parse(_loc_3);
            }
            else
            {
                return null;
            }
            return _loc_2;
        }// end function

        public function getMagicBookCfgByStar(param1:int) : QMagicBookCfg
        {
            var _loc_2:* = (param1 - 1) * 20 + 1;
            var _loc_3:* = new QMagicBookCfg();
            var _loc_4:* = this._map[_loc_2];
            if (this._map[_loc_2])
            {
                _loc_3.parse(_loc_4);
            }
            else
            {
                throw "等级" + _loc_2 + "无法在q_magicbook_level查找";
            }
            return _loc_3;
        }// end function

        public static function getInstance() : QMagicbookLevelCfg
        {
            if (!_instance)
            {
                _instance = new QMagicbookLevelCfg;
            }
            return _instance;
        }// end function

    }
}
