package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;
    import flash.utils.*;

    public class TitleCfgObj extends Object
    {
        private var _mapDic:Dictionary;
        private static var instance:TitleCfgObj;

        public function TitleCfgObj()
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._mapDic = new Dictionary();
            var _loc_1:* = CfgManager.getInstance().getMap("q_title");
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = new TitleCfg();
                _loc_3.parse(_loc_2);
                this._mapDic[_loc_3.q_titleid] = _loc_3;
            }
            return;
        }// end function

        public function getTitleById(param1:int) : TitleCfg
        {
            return this._mapDic[param1];
        }// end function

        public function get MapDic() : Dictionary
        {
            return this._mapDic;
        }// end function

        public static function getInstance() : TitleCfgObj
        {
            if (instance == null)
            {
                instance = new TitleCfgObj;
            }
            return instance;
        }// end function

    }
}
