package com.game.map.view.viewItem
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import interfaces.role.*;

    public class BigMapSimpleItem extends BaseSprite
    {
        private var _imageSP:Bitmap;
        private var _info:BigMapItemInfo;

        public function BigMapSimpleItem()
        {
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._imageSP = new Bitmap();
            this._imageSP.x = 0;
            this._imageSP.y = 100;
            addChild(this._imageSP);
            this.addListener();
            return;
        }// end function

        private function addListener() : void
        {
            addEventListener(MouseEvent.MOUSE_OVER, this._mouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, this._mouseOut);
            addEventListener(MouseEvent.CLICK, this._mouseClick);
            return;
        }// end function

        private function removeListener() : void
        {
            removeEventListener(MouseEvent.MOUSE_OVER, this._mouseOver);
            removeEventListener(MouseEvent.MOUSE_OUT, this._mouseOut);
            removeEventListener(MouseEvent.CLICK, this._mouseClick);
            return;
        }// end function

        private function _mouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this._info && this._info.itemType)
            {
                _loc_2 = RoleList.getInstance().player;
                switch(this._info.itemType)
                {
                    case Params.BIG_MAP_NPC:
                    {
                        _loc_2.pathByCoo(this._info.posX, this._info.posY, 3, 0, true);
                        break;
                    }
                    case Params.BIG_MAP_TRANSFOR:
                    {
                        _loc_2.pathByCoo(this._info.posX, this._info.posY, 3, 0, true);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function _mouseOver(event:MouseEvent) : void
        {
            this.filters = [FrameworkGlobal.YELLOW_TXT_FILTER];
            return;
        }// end function

        private function _mouseOut(event:MouseEvent) : void
        {
            this.filters = [];
            return;
        }// end function

        private function _updateImg() : void
        {
            if (this._info)
            {
                if (this._imageSP)
                {
                    this._imageSP.bitmapData = ToolKit.getNew(this._info.itemType);
                    this._imageSP.x = -this._imageSP.width >> 1;
                    this._imageSP.y = -this._imageSP.height >> 1;
                }
            }
            return;
        }// end function

        private function _loadComplete(param1:BitmapData) : void
        {
            return;
        }// end function

        public function set info(param1:BigMapItemInfo) : void
        {
            if (this._info != param1)
            {
                this._info = param1;
                this._updateImg();
            }
            return;
        }// end function

        public function get info() : BigMapItemInfo
        {
            return this._info;
        }// end function

        public function dispose() : void
        {
            return;
        }// end function

    }
}
