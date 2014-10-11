package com.game.horse.view
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.model.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class HorseAutoCultureTips extends BaseTips
    {
        private var _content:Sprite;
        private var _txtTipsSuper:TextField;
        private var _signTipsSuper:Sprite;
        private var _txtCultureType:TextField;

        public function HorseAutoCultureTips(param1 = null, param2:String = null)
        {
            this.initComp();
            return;
        }// end function

        private function initComp() : void
        {
            if (!this._content)
            {
                this._content = ToolKit.getNew("house_auto_culture_tips");
                this.addChild(this._content);
            }
            this._txtTipsSuper = TextField(this._content.getChildByName("txt_tips_super"));
            this._signTipsSuper = Sprite(this._content.getChildByName("sign_tips_super"));
            this._txtCultureType = TextField(this._content.getChildByName("txt_auto_culture_type"));
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = UserObj.getInstance().playerInfo.vipid;
            if (_loc_2 < 5)
            {
                this._txtTipsSuper.visible = false;
                this._signTipsSuper.visible = false;
                this._txtCultureType.text = LanguageCfgObj.getInstance().getByIndex("10864");
            }
            else if (_loc_2 < 6)
            {
                this._txtCultureType.text = LanguageCfgObj.getInstance().getByIndex("10865");
                this._txtTipsSuper.visible = true;
                this._txtTipsSuper.text = LanguageCfgObj.getInstance().getByIndex("10866");
                this._signTipsSuper.visible = true;
            }
            else
            {
                this._txtCultureType.text = LanguageCfgObj.getInstance().getByIndex("10867");
                this._txtTipsSuper.visible = true;
                this._txtTipsSuper.text = LanguageCfgObj.getInstance().getByIndex("10868");
                this._signTipsSuper.visible = true;
            }
            return;
        }// end function

    }
}
