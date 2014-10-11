package com.game.common
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.*;
    import com.f1.manager.resource.*;
    import com.model.*;
    import com.model.vo.*;

    public class Common extends Object
    {
        public static var moneys:Object = {};
        private static var inited:Boolean;

        public function Common()
        {
            return;
        }// end function

        public static function jobCheck(param1:String, param2:int) : Boolean
        {
            return param1.charAt((param2 - 1)) == "1";
        }// end function

        public static function gameInited() : void
        {
            if (inited)
            {
                return;
            }
            inited = true;
            var _loc_1:* = MusicCfgObj.getInstance().getMusicMap();
            var _loc_2:* = UserObj.getInstance().playerInfo;
            PreVResManager.initCofig(CfgManager.getInstance().getMap("q_upload_resource"), _loc_2.jobkind);
            PreVResManager.loadbyLevel(_loc_2.level);
            _loc_2.addEvtListener(RoleEvent.UPDATE_LEVEL, __reload);
            return;
        }// end function

        public static function __reload(event:RoleEvent) : void
        {
            PreVResManager.loadbyLevel((event.target as RoleInfo).level);
            return;
        }// end function

        moneys["i50001"] = {id:"i50001", name:LanguageCfgObj.getInstance().getByIndex("10122"), tip:LanguageCfgObj.getInstance().getByIndex("10122")};
        moneys["i50002"] = {id:"i50002", name:LanguageCfgObj.getInstance().getByIndex("10120"), tip:LanguageCfgObj.getInstance().getByIndex("10120")};
        moneys["i50003"] = {id:"i50003", name:LanguageCfgObj.getInstance().getByIndex("11963"), tip:LanguageCfgObj.getInstance().getByIndex("11963")};
        moneys["i50004"] = {id:"i50004", name:LanguageCfgObj.getInstance().getByIndex("10048"), tip:LanguageCfgObj.getInstance().getByIndex("10048")};
        moneys["i50005"] = {id:"i50005", name:LanguageCfgObj.getInstance().getByIndex("10119"), tip:LanguageCfgObj.getInstance().getByIndex("10119")};
        moneys["i50006"] = {id:"i50006", name:LanguageCfgObj.getInstance().getByIndex("11964"), tip:LanguageCfgObj.getInstance().getByIndex("11964")};
    }
}
