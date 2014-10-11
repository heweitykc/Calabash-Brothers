package com.game.server.control
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.game.prompt.control.*;
    import com.game.server.message.*;

    public class ServerControl extends Object
    {
        private static var instance:ServerControl;

        public function ServerControl()
        {
            return;
        }// end function

        public function discardHandler(param1:ResDiscardMsgMessage) : void
        {
            if (!FrameworkGlobal.published)
            {
                SimpleTip.show(ToolKit.toPassword(param1.msgid.toString()) + "协议被服务器丢弃了");
            }
            return;
        }// end function

        public function resCloseServerBack(param1:ResCloseServerMessage) : void
        {
            var _loc_2:* = ToolKit.second2TimeStr(param1.time, LanguageCfgObj.getInstance().getByIndex("11127"));
            var _loc_3:* = "";
            if (_loc_2 != "")
            {
                _loc_3 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12182"), [_loc_2]);
            }
            else
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("11128");
            }
            PromptControl.getInstance().addedToBroadcastMarquee(_loc_3);
            return;
        }// end function

        public static function getInstance() : ServerControl
        {
            if (instance == null)
            {
                instance = new ServerControl;
            }
            return instance;
        }// end function

    }
}
