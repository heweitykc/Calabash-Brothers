package com.game.stalls.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.text.*;

    public class IconInfoItem extends Component
    {
        private var _icon:IconItem;
        private var _prefixTxt:TextField;
        private var _nameTxt:TextField;
        private var _intensifyTxt:TextField;
        private var _info:PropInfo;

        public function IconInfoItem(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            return;
        }// end function

        public function get nameTxt() : TextField
        {
            return this._nameTxt;
        }// end function

        public function set nameTxt(param1:TextField) : void
        {
            this._nameTxt = param1;
            return;
        }// end function

        public function get icon() : IconItem
        {
            return this._icon;
        }// end function

        public function set icon(param1:IconItem) : void
        {
            this._icon = param1;
            return;
        }// end function

        public function get info() : PropInfo
        {
            return this._info;
        }// end function

        public function set info(param1:PropInfo) : void
        {
            this._info = param1;
            this._icon.image.x = 6;
            this._icon.image.y = 5;
            this._icon.setInfo(this._info);
            if (this._info is EquipmentInfo)
            {
                if ((this._info as EquipmentInfo).q_remarkable)
                {
                    this._prefixTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11212");
                }
                else
                {
                    this._prefixTxt.text = "";
                }
                this._nameTxt.htmlText = param1.q_name;
                if ((this._info as EquipmentInfo).intensify > 0)
                {
                    this._intensifyTxt.htmlText = "+" + (this._info as EquipmentInfo).intensify.toString();
                }
                else
                {
                    this._intensifyTxt.text = "";
                }
            }
            else
            {
                this._prefixTxt.htmlText = "";
                this._nameTxt.htmlText = param1.q_name;
                this._intensifyTxt.text = "";
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._prefixTxt = getDisplayChildByName("txt_prefix");
            this._nameTxt = getDisplayChildByName("txt_name");
            this._intensifyTxt = getDisplayChildByName("txt_intensify");
            this._icon = new IconItem("shopboxbg");
            this._icon.x = getDisplayChildByName("holder").x;
            this._icon.y = getDisplayChildByName("holder").y;
            this._icon.setImageSize(56, 56);
            addChild(this._icon);
            return;
        }// end function

    }
}
