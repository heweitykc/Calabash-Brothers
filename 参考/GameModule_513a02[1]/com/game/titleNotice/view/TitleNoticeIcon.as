package com.game.titleNotice.view
{
    import com.*;
    import com.f1.*;
    import com.f1.utils.cue.*;
    import com.game.primaryrole.control.*;
    import com.game.titleNotice.control.*;
    import flash.events.*;

    public class TitleNoticeIcon extends ServerHitIcon
    {
        public var titleId:int;

        public function TitleNoticeIcon()
        {
            super("expireServerIcon");
            _content.gotoAndStop(1);
            mouseChildren = false;
            type = "TitleNoticeIcon";
            tipsStr = LanguageCfgObj.getInstance().getByIndex("12364");
            count = 0;
            return;
        }// end function

        override protected function mouseClickHandler(event:MouseEvent) : void
        {
            Global.popManager.removeServerToCue(this);
            Global.popManager.cue(TitleNoticeControl.instance.msgToString, LanguageCfgObj.getInstance().getByIndex("11635"), null, this.onOpenTitlePanel, null, 2, [LanguageCfgObj.getInstance().getByIndex("12365"), LanguageCfgObj.getInstance().getByIndex("12366")]);
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            _content.gotoAndStop(2);
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            _content.gotoAndStop(1);
            return;
        }// end function

        private function onOpenTitlePanel() : void
        {
            PrimaryRoleControl.getInstance().openTitlePanel(this.titleId);
            return;
        }// end function

    }
}
