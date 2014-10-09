package com.game.newactivity.personalInfo.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.newactivity.gift.locale.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class PersonalInfoTip extends BaseTips
    {
        private var _rewards:Array;
        private var bg:Sprite;
        private var viewTitle:TextField;
        private var _content:Sprite;
        private static const LANG:String = "lang_personalInfo";

        public function PersonalInfoTip()
        {
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_6:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            _loc_1 = 30;
            this.bg = ToolKit.getNew("generalHoverWndBg");
            addChild(this.bg);
            this._content = new Sprite();
            this._content.x = 15;
            this._content.y = 0;
            addChild(this._content);
            this.viewTitle = new TextField();
            this.viewTitle.defaultTextFormat = new TextFormat(GiftText.font, 12, 16774656);
            this.viewTitle.autoSize = TextFieldAutoSize.LEFT;
            this.viewTitle.text = LanguageCfgObj.getInstance().getByIndex("pi001", LANG);
            this.viewTitle.x = 48;
            this.viewTitle.y = 20;
            this._content.addChild(this.viewTitle);
            _loc_2 = ToolKit.getNewDO("excisionLine") as Bitmap;
            _loc_2.x = 20;
            _loc_2.y = 38;
            this._content.addChild(_loc_2);
            _loc_3 = new HBox();
            _loc_3.horizontal = true;
            _loc_3.oneRow = 9;
            var _loc_4:* = GlobalCfgObj.getInstance().getCompleteInfoRewards();
            var _loc_5:* = _loc_4.length;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_5)
            {
                
                _loc_6 = new IconItem("commonRewardBox40");
                _loc_6.image.move(8, 8);
                _loc_6.setCountTxtXY(48 - 4, 48 - 14);
                _loc_6.setImageSize(40, 40);
                _loc_6.setInfo(_loc_4[_loc_7]);
                _loc_3.add(_loc_6);
                _loc_7++;
            }
            _loc_3.x = 10;
            _loc_3.y = 50;
            this._content.addChild(_loc_3);
            var _loc_8:* = ToolKit.getNewDO("excisionLine") as Bitmap;
            (_loc_2).x = 20;
            _loc_8.y = 121;
            this._content.addChild(_loc_8);
            var _loc_9:* = ToolKit.getNewDO("excisionLinebg") as Bitmap;
            (_loc_9).x = 26;
            _loc_9.y = _loc_8.y + _loc_8.height;
            this._content.addChild(_loc_9);
            _loc_10 = ToolKit.getNewDO("excisionLine") as Bitmap;
            _loc_10.x = 20;
            _loc_10.y = _loc_9.y + _loc_9.height;
            this._content.addChild(_loc_10);
            _loc_11 = new TextField();
            _loc_11.defaultTextFormat = new TextFormat(GiftText.font, 12, 16774656);
            _loc_11.autoSize = TextFieldAutoSize.LEFT;
            _loc_11.text = LanguageCfgObj.getInstance().getByIndex("pi002", LANG);
            _loc_11.x = 74;
            _loc_11.y = 128;
            this._content.addChild(_loc_11);
            var _loc_12:* = new TextField();
            _loc_11.defaultTextFormat = new TextFormat(GiftText.font, 12, 3394560);
            _loc_12.autoSize = TextFieldAutoSize.LEFT;
            _loc_12.text = LanguageCfgObj.getInstance().getByIndex("pi003", LANG);
            _loc_12.y = _loc_10.y + _loc_10.height + 3;
            this._content.addChild(_loc_12);
            this.bg.width = this._content.width + _loc_1;
            this.bg.height = this._content.height + _loc_1;
            return;
        }// end function

        override public function remove() : void
        {
            super.remove();
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            if (this._rewards)
            {
                this._rewards = GlobalCfgObj.getInstance().getCompleteInfoRewards();
            }
            if (!this._rewards || this._rewards.length <= 0)
            {
                return;
            }
            super.repaint(param1);
            return;
        }// end function

    }
}
