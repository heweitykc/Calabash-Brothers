package com.game.auction.view
{
    import com.f1.ui.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.text.*;

    public class IconInfoItem extends Component
    {
        private var _icon:IconItem;
        private var _prefixTxt:TextField;
        private var _nameTxt:TextField;
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
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this._info = param1;
            this._icon.image.x = 5;
            this._icon.image.y = 5;
            this._icon.setImageSize(56, 56);
            this._icon.setInfo(this._info);
            if (this._info is EquipmentInfo)
            {
                _loc_2 = PropUtil.getEquipColor(this._info);
                _loc_3 = PropUtil.getEquipName(this._info, false, false);
                this._nameTxt.htmlText = "<font color = \'#" + _loc_2.toString(16) + "\'>" + _loc_3 + "</font>";
            }
            else
            {
                this._nameTxt.textColor = PropUtil.getEquipColor(this._info);
                this._nameTxt.text = this._info.q_name;
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._nameTxt = getDisplayChildByName("txt_name");
            this._icon = new IconItem("shopboxbg");
            this._icon.x = getDisplayChildByName("holder").x;
            this._icon.y = getDisplayChildByName("holder").y;
            this._icon.setImageSize(56, 56);
            addChild(this._icon);
            return;
        }// end function

    }
}
