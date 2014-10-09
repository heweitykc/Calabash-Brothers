package com.game.map.view.viewItem
{
    import com.f1.ui.btn.*;
    import com.game.role.util.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.text.*;

    public class WorldMapItem extends Object
    {
        private var _mapButton:BaseButton;
        private var _mapText:TextField;
        private var _info:WorldMapInfo;
        private var _state:String = "up";

        public function WorldMapItem()
        {
            return;
        }// end function

        public function setBtn(param1:BaseButton) : void
        {
            this._mapButton = param1;
            this._mapButton.addEventListener(MouseEvent.MOUSE_OVER, this._over);
            this._mapButton.addEventListener(MouseEvent.MOUSE_OUT, this._out);
            this._mapButton.addEventListener(MouseEvent.MOUSE_DOWN, this._down);
            this._mapButton.addEventListener(MouseEvent.MOUSE_UP, this._up);
            return;
        }// end function

        public function setText(param1:TextField) : void
        {
            this._mapText = param1;
            return;
        }// end function

        public function setObj(param1:WorldMapInfo) : void
        {
            this._info = param1;
            this.updateText();
            return;
        }// end function

        private function updateText() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (this._mapText)
            {
                if (this._info)
                {
                    _loc_2 = UserObj.getInstance().playerInfo.level;
                    if (this._state == "up")
                    {
                        _loc_1 = "<font color=\'#c3a45a\'>" + this._info.mapName + "</font>\n";
                    }
                    else if (this._state == "down")
                    {
                        _loc_1 = "<font color=\'#c3a45a\'>" + this._info.mapName + "</font>\n";
                    }
                    else if (this._state == "over")
                    {
                        _loc_1 = "<font color=\'#ffd47f\'>" + this._info.mapName + "</font>\n";
                    }
                    if (_loc_2 >= this._info.recMinLv && _loc_2 <= this._info.recMaxLv)
                    {
                        _loc_1 = _loc_1 + ("<font color=\'#ffeab7\'>" + RoleLevelUtil.getMasterLevel(this._info.recMinLv, "Lv.") + "-" + RoleLevelUtil.getMasterLevel(this._info.recMaxLv) + "</font>");
                    }
                    else
                    {
                        _loc_1 = _loc_1 + ("<font color=\'#807059\'>" + RoleLevelUtil.getMasterLevel(this._info.recMinLv, "Lv.") + "-" + RoleLevelUtil.getMasterLevel(this._info.recMaxLv) + "</font>");
                    }
                    this._mapText.htmlText = _loc_1;
                }
                else
                {
                    this._mapText.text = "";
                }
            }
            return;
        }// end function

        private function _over(event:MouseEvent) : void
        {
            this._state = "over";
            this.updateText();
            return;
        }// end function

        private function _out(event:MouseEvent) : void
        {
            this._state = "up";
            this.updateText();
            return;
        }// end function

        private function _down(event:MouseEvent) : void
        {
            this._state = "down";
            this.updateText();
            return;
        }// end function

        private function _up(event:MouseEvent) : void
        {
            this._state = "over";
            this.updateText();
            return;
        }// end function

    }
}
