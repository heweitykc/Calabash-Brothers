package com.game.shop.view
{
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.backpack.util.*;
    import com.game.shop.events.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;

    public class OneKeyItem extends Component
    {
        private var _info:PropInfo;
        private var _icon:IconItem;
        private var arrow:Bitmap;

        public function OneKeyItem(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this._icon = new IconItem("backpackbox_bg");
            display.addChildAt(this._icon, 0);
            this.addListener();
            display.gotoAndStop(1);
            return;
        }// end function

        public function get info() : PropInfo
        {
            return this._info;
        }// end function

        public function set info(param1:PropInfo) : void
        {
            this._info = param1;
            this.setInfo(this._info);
            var _loc_2:* = 0;
            if (this._info is EquipmentInfo)
            {
                _loc_2 = EquipUtil.compareEquip(this._info as EquipmentInfo);
                if (_loc_2 != 0)
                {
                    ToolKit.disappear(this.arrow);
                    if (_loc_2 == 1)
                    {
                        this.arrow = ToolKit.getNewDO("equipvalueup") as Bitmap;
                    }
                    else if (_loc_2 == 2)
                    {
                        this.arrow = ToolKit.getNewDO("equipvaluedown") as Bitmap;
                    }
                }
            }
            if (_loc_2 == 0)
            {
                ToolKit.disappear(this.arrow);
            }
            else if (this.arrow)
            {
                this.arrow.x = this._icon.x + this._icon.widthImg - this.arrow.width + 3;
                this.arrow.y = this._icon.heightImg - this.arrow.height + 3;
                addChild(this.arrow);
            }
            return;
        }// end function

        private function addListener() : void
        {
            this.addEventListener(MouseEvent.MOUSE_OVER, this.__over);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.__out);
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            if (this.info)
            {
                display.gotoAndStop(2);
            }
            return;
        }// end function

        public function __out(event:MouseEvent) : void
        {
            if (this.info)
            {
                display.gotoAndStop(1);
            }
            return;
        }// end function

        public function setInfo(param1:Object, param2:Boolean = false) : void
        {
            this._info = param1 as PropInfo;
            if (this._info)
            {
                addEvtListener(MouseEvent.CLICK, this.__click);
                this._icon.setInfo(this._info);
            }
            else
            {
                this._icon.setInfo(null);
                removeEvtListener(MouseEvent.CLICK, this.__click);
            }
            if (this._info == null)
            {
                display.gotoAndStop(1);
            }
            return;
        }// end function

        protected function __click(event:MouseEvent) : void
        {
            dispatchEvent(new ShopEvent(ShopEvent.CANCEL_SOLD, null, true));
            return;
        }// end function

    }
}
