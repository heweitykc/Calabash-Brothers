package com.view.icon
{
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.protect.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.tipcell.*;
    import com.view.waterlight.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class IconItem extends IconBase
    {
        protected var _countTxt:TextField;
        protected var _info:Object;
        protected var _waterLight:WaterLight;
        protected var _qualityOffsetX:int;
        protected var _qualityOffsetY:int;
        protected var qualityEffect:VMCView;
        protected var orginY:int = 0;
        protected var _needQuality:Boolean = true;
        protected var _needTips:Boolean = true;
        protected var equipTipsClass:Class;
        protected var _back:Image;
        protected var _intensifyEffect:VMCView;
        protected var _intensifyImg:ImgNumber;
        protected var _elementEffect:VMCView;
        protected var _intensifyImgOffsetX:int = 1;
        protected var _intensifyImgOffsetY:int = 1;
        protected var _lockImg:Bitmap;
        protected var _protectImg:Bitmap;
        protected var _highProtectImg:Bitmap;
        protected var _lockOffsetX:int = 1;
        protected var _lockOffsetY:int = -1;
        protected var _selected:Boolean = false;
        private var _countNull:Boolean;
        private var waterlightTimeId:int;

        public function IconItem(param1 = "shopboxbg")
        {
            this.equipTipsClass = EquipTips;
            super(param1);
            if (_backImage)
            {
                this.setWH(_backImage.width, _backImage.height);
            }
            this._countTxt = new TextField();
            this._countTxt.type = TextFieldType.DYNAMIC;
            this._countTxt.autoSize = TextFieldAutoSize.RIGHT;
            this._countTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._countTxt.textColor = 16771767;
            var _loc_2:* = this._countTxt.defaultTextFormat;
            _loc_2.font = "SimSun";
            this._countTxt.defaultTextFormat = _loc_2;
            this._countTxt.x = this.width - 5;
            this._countTxt.y = this.height - 15;
            this._countTxt.selectable = false;
            this._countTxt.text = "";
            addChild(this._countTxt);
            this._waterLight = new WaterLight();
            this._waterLight.onComplete = this.setWaterLightWH;
            addChild(this._waterLight);
            this.qualityEffect = new VMCView();
            this.qualityEffect.auto = true;
            this.qualityEffect.updatePose("90", true);
            this.qualityEffect.move(_image.width / 2 + 1, _image.height / 2);
            addChild(this.qualityEffect);
            this._elementEffect = new VMCView();
            this._elementEffect.scale = 0.6;
            this._elementEffect.auto = true;
            this._elementEffect.updatePose("90", true);
            this._elementEffect.move(this.width / 2, this.height / 2);
            addChild(this._elementEffect);
            this._intensifyEffect = new VMCView();
            this._intensifyEffect.auto = true;
            this._intensifyEffect.updatePose("90", true);
            this._intensifyEffect.move(_image.width / 2 + 1, _image.height / 2);
            addChild(this._intensifyEffect);
            return;
        }// end function

        override public function setWH(param1:uint, param2:uint) : void
        {
            super.setWH(param1, param2);
            if (!_backImage)
            {
                this._countTxt.x = 0;
                this._countTxt.y = param2 - 17;
                this._countTxt.width = param1;
            }
            return;
        }// end function

        public function get countNull() : Boolean
        {
            return this._countNull;
        }// end function

        public function set countNull(param1:Boolean) : void
        {
            this._countNull = param1;
            return;
        }// end function

        public function get intensifyImgOffsetX() : int
        {
            return this._intensifyImgOffsetX;
        }// end function

        public function set intensifyImgOffsetX(param1:int) : void
        {
            this._intensifyImgOffsetX = param1;
            return;
        }// end function

        public function get intensifyImgOffsetY() : int
        {
            return this._intensifyImgOffsetY;
        }// end function

        public function set intensifyImgOffsetY(param1:int) : void
        {
            this._intensifyImgOffsetY = param1;
            return;
        }// end function

        public function get lockOffsetY() : int
        {
            return this._lockOffsetY;
        }// end function

        public function set lockOffsetY(param1:int) : void
        {
            this._lockOffsetY = param1;
            return;
        }// end function

        public function get lockOffsetX() : int
        {
            return this._lockOffsetX;
        }// end function

        public function set lockOffsetX(param1:int) : void
        {
            this._lockOffsetX = param1;
            return;
        }// end function

        public function get needTips() : Boolean
        {
            return this._needTips;
        }// end function

        public function set needTips(param1:Boolean) : void
        {
            this._needTips = param1;
            return;
        }// end function

        public function get needQuality() : Boolean
        {
            return this._needQuality;
        }// end function

        public function set needQuality(param1:Boolean) : void
        {
            this._needQuality = param1;
            return;
        }// end function

        public function get info()
        {
            return this._info;
        }// end function

        public function get qualityOffsetY() : int
        {
            return this._qualityOffsetY;
        }// end function

        public function set qualityOffsetY(param1:int) : void
        {
            this._qualityOffsetY = param1;
            return;
        }// end function

        public function get qualityOffsetX() : int
        {
            return this._qualityOffsetX;
        }// end function

        public function set qualityOffsetX(param1:int) : void
        {
            this._qualityOffsetX = param1;
            return;
        }// end function

        public function setCountTxtXY(param1:int, param2:int) : void
        {
            this._countTxt.x = param1;
            this._countTxt.y = param2;
            return;
        }// end function

        override public function setInfo(param1:Object, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this.cleanWaterLight();
            if (this._info)
            {
                this._info.removeEvtListener(Event.CHANGE, this.__change);
            }
            this._info = param1 as PropInfo;
            if (this._info)
            {
                addEvtListener(MouseEvent.CLICK, __click);
                addEvtListener("rightClick", __rightClick);
                addEvtListener(MouseEvent.ROLL_OVER, this.__itemover);
                addEvtListener(MouseEvent.ROLL_OUT, this.__itemout);
                if (this._info.q_type == ItemType.ELEMENT_HEART)
                {
                    this._elementEffect.loadRes(this._info.effectUrl, null, true);
                    this._elementEffect.auto = true;
                }
                else
                {
                    this._elementEffect.url = null;
                    this._elementEffect.finalize();
                }
                if (this._countNull)
                {
                    this.drawCount(false);
                }
                else
                {
                    this.drawCount();
                }
                if (this._info.url != _image.url || param2)
                {
                    _image.smoothing = true;
                    _image.load(this._info.url, this.onComplete);
                }
                else
                {
                    clearTimeout(this.waterlightTimeId);
                    this.waterlightTimeId = setTimeout(this.setWaterLight, 100);
                }
                if (this.needQuality)
                {
                    _loc_4 = PropUtil.getQualityColor(this._info);
                    _loc_5 = "";
                    if (_loc_4 != "")
                    {
                        if (_widthImg == 40)
                        {
                            _loc_5 = "res/effect/40/" + _loc_4 + ".png";
                        }
                        else
                        {
                            _loc_5 = "res/effect/56/" + _loc_4 + ".png";
                        }
                        this.qualityEffect.loadRes(_loc_5, null, true);
                        this.qualityEffect.auto = true;
                        this.qualityEffect.move(_w >> 1 + this.qualityOffsetY, _h >> 1 + this.qualityOffsetY);
                    }
                    else
                    {
                        this.qualityEffect.url = null;
                        this.qualityEffect.finalize();
                    }
                    if (this._info.intensify >= 13)
                    {
                        if (_widthImg == 40)
                        {
                            _loc_5 = "res/effect/40/13.png";
                        }
                        else
                        {
                            _loc_5 = "res/effect/56/13.png";
                        }
                        this._intensifyEffect.loadRes(_loc_5, null, true);
                        this._intensifyEffect.auto = true;
                        this._intensifyEffect.move(_w >> 1 + this.qualityOffsetY, _h >> 1 + this.qualityOffsetY);
                    }
                    else if (this._info.intensify >= 11)
                    {
                        if (_widthImg == 40)
                        {
                            _loc_5 = "res/effect/40/11.png";
                        }
                        else
                        {
                            _loc_5 = "res/effect/56/13.png";
                        }
                        this._intensifyEffect.loadRes(_loc_5, null, true);
                        this._intensifyEffect.auto = true;
                        this._intensifyEffect.move(_w >> 1 + this.qualityOffsetY, _h >> 1 + this.qualityOffsetY);
                    }
                    else
                    {
                        this._intensifyEffect.url = null;
                        this._intensifyEffect.finalize();
                    }
                }
                else
                {
                    this.qualityEffect.finalize();
                    this._intensifyEffect.finalize();
                }
                if (this._info.intensify > 0)
                {
                    if (this._intensifyImg == null)
                    {
                        this._intensifyImg = new ImgNumber();
                    }
                    this._intensifyImg.setNumber("+" + this._info.intensify, 9, -2);
                    this._intensifyImg.move(_image.x + this._intensifyImgOffsetX, _image.y + this._intensifyImgOffsetY);
                    addChild(this._intensifyImg);
                }
                else if (this._intensifyImg && this._intensifyImg.parent)
                {
                    this._intensifyImg.parent.removeChild(this._intensifyImg);
                }
                if (this._info.isbind)
                {
                    if (this._lockImg == null)
                    {
                        this._lockImg = ToolKit.getNewDO("bindIcon") as Bitmap;
                        this._lockImg.x = _image.x + this._lockOffsetX;
                        this._lockImg.y = _image.y + _widthImg - this._lockImg.height + this._lockOffsetY;
                    }
                    addChild(this._lockImg);
                }
                else if (this._lockImg && this._lockImg.parent)
                {
                    this._lockImg.parent.removeChild(this._lockImg);
                }
                if (_widthImg == 40)
                {
                    if (!this._back)
                    {
                        this._back = new Image();
                        this._back.move(_image.x, _image.y);
                        this._back.load("res/effect/40/back.png");
                    }
                    ProtectManager.updateItemView(this, this._info);
                    ProtectManager.updateItemViewHigh(this, this._info);
                }
                else if (_widthImg == 56)
                {
                    if (!this._back)
                    {
                        this._back = new Image();
                        this._back.load("res/effect/56/back.png");
                        this._back.move(_image.x, _image.y);
                    }
                }
                _loc_3 = new Object();
                if (this.needTips)
                {
                    if (PropUtil.isSpecial(this._info.itemModelId))
                    {
                        ItemTips.create(this, this._info, CurrencyTips);
                    }
                    else if (this._info is EquipmentInfo)
                    {
                        ItemTips.create(this, this._info, this.equipTipsClass);
                    }
                    else if (this._info.q_type == ItemType.ELEMENT_HEART)
                    {
                        _loc_3 = PropUtil.createElementHeartById(this._info.q_value);
                        ItemTips.create(this, _loc_3, ElementHeartTips);
                    }
                    else
                    {
                        ItemTips.create(this, this._info, PropTips);
                    }
                }
                this._info.addEvtListener(Event.CHANGE, this.__change);
                addEvtListener(Event.REMOVED_FROM_STAGE, this.cleanEffect);
            }
            else
            {
                this.drawCount(false);
                this.qualityEffect.url = null;
                this.qualityEffect.finalize();
                this._elementEffect.url = null;
                this._elementEffect.finalize();
                this._intensifyEffect.url = null;
                this._intensifyEffect.finalize();
                if (this._lockImg && this._lockImg.parent)
                {
                    this._lockImg.parent.removeChild(this._lockImg);
                }
                if (this._intensifyImg && this._intensifyImg.parent)
                {
                    this._intensifyImg.parent.removeChild(this._intensifyImg);
                }
                ProtectManager.updateItemView(this, null);
                ProtectManager.updateItemViewHigh(this, null);
                removeEvtListener(MouseEvent.CLICK, __click);
                removeEvtListener("rightClick", __rightClick);
                ItemTips.dispose(this);
                _image.dispose();
                if (this._waterLight.bitmapData)
                {
                    this._waterLight.bitmapData.dispose();
                }
                removeEvtListener(Event.REMOVED_FROM_STAGE, this.cleanEffect);
            }
            return;
        }// end function

        private function __change(event:Event) : void
        {
            this.setInfo(this._info, true);
            return;
        }// end function

        private function addEffect(event:Event) : void
        {
            this.cleanWaterLight();
            if (this._info)
            {
                clearTimeout(this.waterlightTimeId);
                this.waterlightTimeId = setTimeout(this.setWaterLight, 100);
                if (this.qualityEffect.url)
                {
                    this.qualityEffect.play();
                }
                if (this._intensifyEffect.url)
                {
                    this._intensifyEffect.play();
                }
                if (this._elementEffect.url)
                {
                    this._elementEffect.play();
                }
            }
            return;
        }// end function

        private function cleanEffect(event:Event = null) : void
        {
            this.cleanWaterLight();
            if (this.qualityEffect)
            {
                this.qualityEffect.stop();
            }
            if (this._intensifyEffect)
            {
                this._intensifyEffect.stop();
            }
            if (this._elementEffect)
            {
                this._elementEffect.stop();
            }
            addEvtListener(Event.ADDED_TO_STAGE, this.addEffect);
            return;
        }// end function

        public function setImageXY(param1:int, param2:int) : void
        {
            _image.x = param1;
            _image.y = param2;
            return;
        }// end function

        public function set count(param1:Number) : void
        {
            if (param1 == 1 || param1 == 0)
            {
                this._countTxt.text = "";
            }
            else
            {
                param1 = param1 > (this._info as PropInfo).num ? ((this._info as PropInfo).num) : (param1);
                this._countTxt.text = ToolKit.getUintStr(param1);
            }
            return;
        }// end function

        public function setCount(param1:Number, param2:Boolean = false) : void
        {
            if ((param1 == 1 || param1 == 0) && !param2)
            {
                this._countTxt.text = "";
            }
            else
            {
                param1 = param1 > (this._info as PropInfo).num ? ((this._info as PropInfo).num) : (param1);
                this._countTxt.text = ToolKit.getUintStr(param1);
            }
            return;
        }// end function

        public function countSpecific(param1:Number) : void
        {
            if (param1 == 1 || param1 == 0)
            {
                this._countTxt.text = "";
            }
            else
            {
                this._countTxt.text = ToolKit.getUintStr(param1);
            }
            return;
        }// end function

        protected function __itemover(event:MouseEvent) : void
        {
            if (this._back && this._info && !this._selected)
            {
                addChildAt(this._back, (getChildIndex(_image) + 1));
            }
            return;
        }// end function

        protected function __itemout(event:MouseEvent) : void
        {
            if (this._back && this._back.parent && !this._selected)
            {
                this._back.parent.removeChild(this._back);
            }
            return;
        }// end function

        protected function onComplete(param1:BitmapData) : void
        {
            _image.height = _widthImg;
            _image.width = _heightImg;
            this.setWaterLight();
            return;
        }// end function

        protected function setWaterLightWH() : void
        {
            this._waterLight.width = _widthImg;
            this._waterLight.height = _heightImg;
            return;
        }// end function

        protected function setWaterLight() : void
        {
            var _loc_1:* = 0;
            if (this._info is EquipmentInfo && this._info.intensify >= 7)
            {
                _loc_1 = this.getWaterLightColor(this._info.intensify, EquipmentInfo(this._info).q_shine_color);
                this._waterLight.sourceBmd = _image.bitmapData;
                this._waterLight.color = _loc_1;
                this._waterLight.updateWaterLight();
                this._waterLight.move(_image.x, _image.y);
            }
            return;
        }// end function

        private function getWaterLightColor(param1:int, param2:String) : uint
        {
            var _loc_3:* = param2.split(";");
            if (_loc_3.length == 1)
            {
                return _loc_3[0];
            }
            if (param1 >= 9)
            {
                return uint(_loc_3[1]);
            }
            if (param1 >= 7)
            {
                return uint(_loc_3[0]);
            }
            return uint(_loc_3[0]);
        }// end function

        private function cleanWaterLight() : void
        {
            if (this._waterLight)
            {
                if (this._waterLight.playing)
                {
                    this._waterLight.stop();
                }
                if (this._waterLight.bitmapData)
                {
                    this._waterLight.bitmapData.dispose();
                }
                this._waterLight.finalize();
            }
            return;
        }// end function

        protected function drawCount(param1:Boolean = true) : void
        {
            if (param1)
            {
                if ((this._info as PropInfo).num > 1)
                {
                    this._countTxt.text = ToolKit.getUintStr((this._info as PropInfo).num);
                }
                else
                {
                    this._countTxt.text = "";
                }
            }
            else
            {
                this._countTxt.text = "";
            }
            return;
        }// end function

        public function set protectImg(param1:Bitmap) : void
        {
            if (this._protectImg != null)
            {
                removeChild(this._protectImg);
            }
            this._protectImg = param1;
            if (this._protectImg != null)
            {
                addChild(this._protectImg);
            }
            return;
        }// end function

        public function get protectImg() : Bitmap
        {
            return this._protectImg;
        }// end function

        public function set highProtectImg(param1:Bitmap) : void
        {
            if (this._highProtectImg != null)
            {
                removeChild(this._highProtectImg);
            }
            this._highProtectImg = param1;
            if (this._highProtectImg != null)
            {
                addChild(this._highProtectImg);
            }
            return;
        }// end function

        public function get highProtectImg() : Bitmap
        {
            return this._highProtectImg;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            this.cleanWaterLight();
            this.qualityEffect.finalize();
            this._intensifyEffect.finalize();
            this._elementEffect.finalize();
            if (this._back)
            {
                this._back = null;
            }
            if (_image)
            {
                _image = null;
            }
            return;
        }// end function

        override public function setImageSize(param1:int, param2:int) : void
        {
            super.setImageSize(param1, param2);
            if (this._waterLight)
            {
                this._waterLight.width = _widthImg;
                this._waterLight.height = _heightImg;
            }
            return;
        }// end function

        public function get countTxt() : TextField
        {
            return this._countTxt;
        }// end function

        public function get setSelected() : Boolean
        {
            return this._selected;
        }// end function

        public function set setSelected(param1:Boolean) : void
        {
            this._selected = param1;
            if (this._back && this._info && this._selected)
            {
                addChildAt(this._back, (getChildIndex(_image) + 1));
            }
            if (this._back && this._back.parent && !this._selected)
            {
                this._back.parent.removeChild(this._back);
            }
            return;
        }// end function

    }
}
