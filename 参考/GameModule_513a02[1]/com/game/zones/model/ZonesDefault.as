package com.game.zones.model
{
    import com.f1.*;
    import flash.utils.*;

    public class ZonesDefault extends Object
    {
        private var errorDic:Dictionary;
        private static var _instance:ZonesDefault;

        public function ZonesDefault()
        {
            this.errorDic = new Dictionary();
            this.initDic();
            return;
        }// end function

        private function initDic() : void
        {
            this.errorDic[1] = LanguageCfgObj.getInstance().getByIndex("11464");
            this.errorDic[2] = LanguageCfgObj.getInstance().getByIndex("11465");
            this.errorDic[3] = LanguageCfgObj.getInstance().getByIndex("11466");
            this.errorDic[4] = LanguageCfgObj.getInstance().getByIndex("11467");
            this.errorDic[5] = LanguageCfgObj.getInstance().getByIndex("11468");
            this.errorDic[6] = LanguageCfgObj.getInstance().getByIndex("11469");
            this.errorDic[7] = LanguageCfgObj.getInstance().getByIndex("11470");
            this.errorDic[8] = LanguageCfgObj.getInstance().getByIndex("11471");
            this.errorDic[9] = LanguageCfgObj.getInstance().getByIndex("11472");
            this.errorDic[10] = LanguageCfgObj.getInstance().getByIndex("11473");
            this.errorDic[11] = LanguageCfgObj.getInstance().getByIndex("11474");
            this.errorDic[12] = LanguageCfgObj.getInstance().getByIndex("11475");
            return;
        }// end function

        public function getErrorCode(param1:int) : String
        {
            return this.errorDic[param1];
        }// end function

        public static function getInstance() : ZonesDefault
        {
            if (!_instance)
            {
                _instance = new ZonesDefault;
            }
            return _instance;
        }// end function

    }
}
