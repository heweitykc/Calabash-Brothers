package com.game.facebook.cfg
{
    import com.util.*;

    public class FacebookShareCfgObj extends Object
    {
        private var map:Object;
        private static var instance:FacebookShareCfgObj;

        public function FacebookShareCfgObj()
        {
            this.map = CfgUtil.getAndConvertMap("q_facebook_share", FacebookShareCfg);
            return;
        }// end function

        public function getCfg(param1:String) : FacebookShareCfg
        {
            return this.map[param1];
        }// end function

        public static function getInstance() : FacebookShareCfgObj
        {
            var _loc_1:* = new FacebookShareCfgObj;
            instance = new FacebookShareCfgObj;
            return instance || _loc_1;
        }// end function

    }
}
