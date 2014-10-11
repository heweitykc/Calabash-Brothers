package com.game.map.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import flash.events.*;
    import flash.text.*;

    public class ScreenShieldCueBox extends SysCueBox
    {

        public function ScreenShieldCueBox()
        {
            super("new_sys_cue_box1");
            return;
        }// end function

        override protected function initUI() : void
        {
            closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            closeBtn.visible = false;
            var _loc_1:* = UITool.getStyleButton(getDisplayChildByName("yes_btn"));
            _loc_1.visible = false;
            yesBtn = new BaseButton(ToolKit.getNew("generalLowRed_btn"));
            display.addChild(yesBtn);
            yesBtn.move(_loc_1.x, _loc_1.y);
            noBtn = UITool.getStyleButton(getDisplayChildByName("no_btn"));
            yesBtn.setText(LanguageCfgObj.getInstance().getByIndex("10949"));
            noBtn.setText(LanguageCfgObj.getInstance().getByIndex("10950"));
            checkBtn = new BaseButton(getDisplayChildByName("check_btn"), true);
            checkBtn.visible = false;
            checkBtn.setText(LanguageCfgObj.getInstance().getByIndex("10951"));
            txt = getDisplayChildByName("txt") as TextField;
            _titleTxt = getDisplayChildByName("txt_title");
            if (txt)
            {
                txt.autoSize = TextFieldAutoSize.LEFT;
                txt.multiline = true;
                txt.wordWrap = true;
                txt.filters = [BLACK_FILTER];
            }
            yesBtn.addEventListener(MouseEvent.CLICK, __yes, false, 0, true);
            if (closeBtn)
            {
                closeBtn.addEventListener(MouseEvent.CLICK, __close, false, 0, true);
            }
            noBtn.addEventListener(MouseEvent.CLICK, __close, false, 0, true);
            checkBtn.addEventListener(MouseEvent.CLICK, __check, false, 0, true);
            layoutMC(closeBtn, Layout.RIGHT, 6, 6);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

    }
}
