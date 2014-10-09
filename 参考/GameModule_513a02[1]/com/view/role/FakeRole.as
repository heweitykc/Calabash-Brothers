package com.view.role
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.text.*;

    public class FakeRole extends Sprite
    {
        private var mc:MovieClip;
        private var _progress_txt:TextField;

        public function FakeRole()
        {
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc = ToolKit.getNew("defalut_qq_mc");
            if (this.mc)
            {
                addChild(this.mc);
                this._progress_txt = this.mc.getChildByName("progress_txt") as TextField;
            }
            return;
        }// end function

        public function reset() : void
        {
            this._progress_txt.htmlText = "";
            return;
        }// end function

        public function setShowing(param1:Boolean) : void
        {
            this.visible = param1;
            return;
        }// end function

        public function setProgress(param1:uint) : void
        {
            if (this._progress_txt)
            {
                if (param1 < 100)
                {
                    this._progress_txt.htmlText = param1 + "%";
                }
                else
                {
                    this._progress_txt.htmlText = "<font size=\'12px\'>" + LanguageCfgObj.getInstance().getByIndex("11787") + "</font>";
                }
            }
            return;
        }// end function

    }
}
