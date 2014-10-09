package com.game.map.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.vmc.*;
    import com.game.map.bean.*;
    import com.game.map.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class DropIcon extends BaseSprite
    {
        private var _dropInfo:DropGoodsInfo;
        private var _modelInfo:PropInfo;
        private var _image:Image;
        private var _effect:VMCView;
        private var _shadow:Bitmap;
        private var _txtName:Bitmap;
        private static const nameFormat:TextFormat = new TextFormat(Params.FONT1, 12, 16777215);

        public function DropIcon()
        {
            this._shadow = new Bitmap();
            this.initIcon();
            return;
        }// end function

        public function get modelInfo() : PropInfo
        {
            return this._modelInfo;
        }// end function

        public function get dropInfo() : DropGoodsInfo
        {
            return this._dropInfo;
        }// end function

        public function set dropInfo(param1:DropGoodsInfo) : void
        {
            if (this._dropInfo != param1)
            {
                this._dropInfo = param1;
                this.setIcon();
            }
            return;
        }// end function

        private function initIcon() : void
        {
            this._image = new Image();
            this.addChild(this._image);
            this.mouseChildren = false;
            return;
        }// end function

        private function addEvents() : void
        {
            addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            addEvtListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            addEvtListener(MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            return;
        }// end function

        private function removeEvents() : void
        {
            removeEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            removeEvtListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            removeEvtListener(MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            if (!this._dropInfo)
            {
                this.clean();
                return;
            }
            RoleList.getInstance().player.addEvtListener(RoleEvent.ARRIVE, this.runToIcon);
            RoleList.getInstance().player.pathByCoo(this.dropInfo.x, this.dropInfo.y, 0, 0, false, false);
            return;
        }// end function

        public function runToIcon(event:RoleEvent) : void
        {
            RoleList.getInstance().player.removeEvtListener(RoleEvent.ARRIVE, this.runToIcon);
            if (!this.dropInfo)
            {
                return;
            }
            if (this.getDistance(this.dropInfo.x, this.dropInfo.y, RoleList.getInstance().player._x, RoleList.getInstance().player._y) <= 75)
            {
                MapControl.getInstance().dropTakeUpGoods(this);
            }
            return;
        }// end function

        private function getDistance(param1:int, param2:int, param3:Number, param4:Number) : int
        {
            return Math.sqrt(Math.pow(param3 - param1, 2) + Math.pow(param4 - param4, 2));
        }// end function

        private function mouseOverHandler(event:MouseEvent) : void
        {
            Global.primaryCursorManager.showGetIcon();
            this._txtName.filters = [FrameworkGlobal.YELLOW_TXT_FILTER];
            this._image.filters = [FrameworkGlobal.YELLOW_TXT_FILTER];
            this._effect.filters = [FrameworkGlobal.YELLOW_TXT_FILTER];
            this.parent.setChildIndex(this, (this.parent.numChildren - 1));
            return;
        }// end function

        private function mouseOutHandler(event:MouseEvent) : void
        {
            Global.primaryCursorManager.hide();
            this._image.filters = [];
            this._effect.filters = [];
            this._txtName.filters = [];
            return;
        }// end function

        private function setIcon() : void
        {
            var _loc_1:* = this._dropInfo.itemModelId;
            var _loc_2:* = ItemCfgObj.getInstance().getCfgBy(_loc_1);
            if (_loc_2 == null)
            {
                return;
            }
            if (!PropUtil.isEquip(_loc_2.q_type))
            {
                this._modelInfo = new PropInfo();
                if (PropUtil.isElementHeart(_loc_2.q_type))
                {
                    this._modelInfo.effectUrl = PropUtil.createElementHeartById(_loc_2.q_value).effectUrl;
                }
            }
            else
            {
                this._modelInfo = new EquipmentInfo();
            }
            this._modelInfo.convByCfg(_loc_1);
            this.freshIcon();
            if (!this.hasEventListener(MouseEvent.CLICK))
            {
                this.addEvents();
            }
            return;
        }// end function

        private function freshIcon() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (!this._image)
            {
                this._image = new Image();
                this.addChild(this._image);
            }
            this._image.load(Params.DROP_PATH + this._modelInfo.q_drop_model + ".png", this.onComplete);
            if (!this._effect)
            {
                this._effect = new VMCView();
                this._effect.scale = 0.4;
                this._effect.auto = true;
                addChild(this._effect);
                this._effect.updatePose("90", true);
            }
            if (this._modelInfo.effectUrl)
            {
                this._effect.loadRes(this._modelInfo.effectUrl, null, false, this.onComplete);
            }
            if (this._modelInfo is EquipmentInfo)
            {
                this._modelInfo.intensify = this.dropInfo.intensify;
                this._modelInfo.addAttributLevel = this.dropInfo.addition;
                this._modelInfo.attribute = this.dropInfo.attributs;
                _loc_1 = PropUtil.getEquipNameAndColor(this._modelInfo as EquipmentInfo)[1];
                _loc_2 = PropUtil.getEquipNameAndColor(this._modelInfo as EquipmentInfo)[0];
                if (this.dropInfo.addition > 0)
                {
                    _loc_2 = _loc_2 + LanguageCfgObj.getInstance().getByIndex("12099");
                }
            }
            else
            {
                _loc_1 = PropUtil.getPropColor(this._modelInfo.q_quality_lv);
            }
            var _loc_3:* = this._dropInfo.itemModelId;
            if (_loc_3 == 700034 || _loc_3 == 700035 || _loc_3 == 700036)
            {
                _loc_2 = this.dropInfo.num + Params.MONEY2_NAME;
            }
            else
            {
                _loc_2 = _loc_2 == null ? (this._modelInfo.q_name) : (_loc_2);
            }
            if (this._txtName)
            {
                if (this._txtName.parent)
                {
                    this._txtName.parent.removeChild(this._txtName);
                }
            }
            nameFormat.color = _loc_1;
            nameFormat.align = TextFormatAlign.CENTER;
            this._txtName = TxtImage.getTxtImage(_loc_2, nameFormat);
            this._txtName.y = -30;
            this._txtName.x = (-this._txtName.width) / 2;
            addChild(this._txtName);
            this.move(this._dropInfo.x, this._dropInfo.y);
            return;
        }// end function

        private function onComplete(... args) : void
        {
            if (!this._dropInfo)
            {
                this.clean();
                return;
            }
            this._image.move((-this._image.width) / 2, (-this._image.height) / 2);
            if (this._shadow)
            {
                if (this._shadow.bitmapData)
                {
                    this._shadow.bitmapData.dispose();
                }
                this._shadow.bitmapData = null;
            }
            args = new Matrix();
            args.a = 1;
            args.b = 0;
            args.c = Math.tan(15 * Math.PI / 180);
            args.d = 0.8;
            var _loc_3:* = new ColorTransform(0, 0, 0, 0.5);
            if (this._modelInfo.effectUrl)
            {
                if (this._effect.bitmapData)
                {
                    this._shadow.bitmapData = this._effect.bitmapData.clone();
                    this._shadow.transform.matrix = args;
                    this._shadow.transform.colorTransform = _loc_3;
                    this._shadow.scaleX = 0.4;
                    this._shadow.scaleY = 0.4;
                    this._shadow.x = (-this._shadow.width) / 2 - 8;
                    this._shadow.y = -5;
                }
            }
            else
            {
                this._shadow.bitmapData = this._image.bitmapData.clone();
                this._shadow.transform.matrix = args;
                this._shadow.transform.colorTransform = _loc_3;
                this._shadow.x = this._image.x - 15;
                this._shadow.y = this._image.y + 5;
            }
            this.addChildAt(this._shadow, 0);
            this.move(this._dropInfo.x - this._image.width / 2, this._dropInfo.y - this._image.height / 2);
            return;
        }// end function

        public function reset() : void
        {
            this.clean();
            if (this._effect)
            {
                if (this._effect.parent)
                {
                    this._effect.parent.removeChild(this._effect);
                }
                if (this._effect.url)
                {
                    this._effect.stop();
                    this._effect.url = null;
                    this._effect.finalize();
                }
                this._effect = null;
            }
            return;
        }// end function

        public function clean() : void
        {
            if (this._image)
            {
                this._image.dispose();
            }
            this._dropInfo = null;
            this._modelInfo = null;
            this.removeEvents();
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

    }
}
