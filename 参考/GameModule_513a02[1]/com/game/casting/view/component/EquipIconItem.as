package com.game.casting.view.component
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.game.backpack.util.*;
    import com.game.casting.bean.*;
    import com.game.casting.control.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;

    public class EquipIconItem extends IconItem
    {
        private var _obj:CastingGridInfo;
        private var _flashFont:BaseSprite;
        private var _hitSp:Sprite;
        private var _icon:Bitmap;

        public function EquipIconItem(param1:String = "PropBox66")
        {
            super(param1);
            setWH(66, 66);
            image.move(6, 6);
            _backImage.alpha = 0.5;
            setImageSize(56, 56);
            setCountTxtXY(66 - 10, 66 - 20);
            return;
        }// end function

        override protected function initHitArea() : void
        {
            _hitShape.graphics.beginFill(0, 0);
            _hitShape.graphics.drawRect(-3, -3, _backImage.width + 3, _backImage.height + 3);
            _hitShape.graphics.endFill();
            this.addChild(_hitShape);
            this.hitArea = _hitShape;
            return;
        }// end function

        public function get obj() : CastingGridInfo
        {
            return this._obj;
        }// end function

        public function setEquipInfo(param1:CastingGridInfo) : void
        {
            this._obj = param1;
            setInfo(param1 ? (PropUtil.createItemByItemInfo(param1.iteminfo)) : (null));
            this.desideIcon();
            return;
        }// end function

        public function showflash(param1:int, param2:int) : void
        {
            var _loc_4:* = null;
            if (!this._flashFont)
            {
                this._flashFont = new BaseSprite();
                addChild(this._flashFont);
            }
            this._flashFont._y = 20;
            this._flashFont.alpha = 1;
            ToolKit.clearMcChild(this._flashFont);
            var _loc_3:* = new ImgNumber();
            _loc_3.setNumber("+" + param2, 9, -2);
            _loc_3._x = 10;
            this._flashFont.addChild(_loc_3);
            if (param1 == 1)
            {
                _loc_4 = ToolKit.getNewDO("zhuzao_gongyi");
            }
            else
            {
                _loc_4 = ToolKit.getNewDO("icon_gold");
            }
            _loc_4.x = _loc_3._x + _loc_3.width;
            this._flashFont.addChild(_loc_4);
            TweenLite.to(this._flashFont, 2, {y:-20, alpha:0});
            return;
        }// end function

        public function desideIcon() : void
        {
            var _loc_1:* = 0;
            if (_info is EquipmentInfo)
            {
                _loc_1 = EquipUtil.compareEquip(_info as EquipmentInfo);
            }
            this.needIcon = _loc_1;
            return;
        }// end function

        public function set needIcon(param1:int) : void
        {
            if (param1 == 0)
            {
                if (this._icon)
                {
                    if (this._icon.parent)
                    {
                        this._icon.parent.removeChild(this._icon);
                    }
                    this._icon = null;
                }
            }
            else
            {
                if (this._icon)
                {
                    if (this._icon.parent)
                    {
                        this._icon.parent.removeChild(this._icon);
                    }
                    this._icon = null;
                }
                if (param1 == 1)
                {
                    this._icon = ToolKit.getNewDO("itemup56") as Bitmap;
                }
                else if (param1 == 2)
                {
                    this._icon = ToolKit.getNewDO("itemdown56") as Bitmap;
                }
                this._icon.x = _backImage.x + _backImage.width - this._icon.width - 4;
                this._icon.y = _backImage.y + _backImage.height - this._icon.height - 4;
                addChild(this._icon);
            }
            return;
        }// end function

        override protected function doDoubleClick() : void
        {
            this.pack();
            super.doDoubleClick();
            return;
        }// end function

        public function pack() : void
        {
            var _loc_1:* = null;
            if (this._obj && this._obj.iteminfo)
            {
                _loc_1 = PropUtil.createItemByItemInfo(this._obj.iteminfo);
                if (_loc_1.q_type == 26)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10431"));
                    return;
                }
                ZhuZaoControl.getInstance().reqCastingUseItemToServer(this._obj.grididx, 1);
            }
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}
