package com.game.task.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;

    public class RewardBox extends Component
    {
        public var textField:TextField;
        public var img:Image;
        protected var qualityEffect:VMCView;
        private var _info:Object;
        public var _lockImg:DisplayObject;

        public function RewardBox(param1 = "commonRewardBox40")
        {
            super(param1);
            this.img = new Image();
            this.img.x = 8;
            this.img.y = 8;
            this.img.width = 40;
            this.img.height = 40;
            addChild(this.img);
            this.textField = new TextField();
            this.textField.textColor = 16771767;
            this.textField.x = 5;
            this.textField.y = 35;
            this.textField.defaultTextFormat = new TextFormat("宋体", 12, 16771767, null, null, null, null, null, "right");
            this.textField.width = 46;
            this.textField.height = 20;
            this.textField.mouseEnabled = false;
            this.textField.filters = [new GlowFilter(0, 1, 3, 3)];
            addChild(this.textField);
            return;
        }// end function

        public function set text(param1:String) : void
        {
            var _loc_3:* = NaN;
            var _loc_2:* = Number(param1);
            if (_loc_2 >= 100000000)
            {
                this.textField.text = Math.floor(_loc_2 / 100000000).toFixed(0) + LanguageCfgObj.getInstance().getByIndex("11783");
            }
            else if (_loc_2 >= 10000)
            {
                _loc_3 = _loc_2 * 0.0001;
                if (_loc_2 % 10000 == 0)
                {
                    this.textField.text = _loc_3.toFixed(0) + LanguageCfgObj.getInstance().getByIndex("10030");
                }
                else
                {
                    this.textField.text = _loc_3.toFixed(1) + LanguageCfgObj.getInstance().getByIndex("10030");
                }
            }
            else
            {
                this.textField.text = _loc_2.toString();
            }
            return;
        }// end function

        public function image(param1:String, param2:int = 0, param3:int = 0) : void
        {
            if (this.img)
            {
                this.img.dispose();
                this.img.load(param1, this.completeFunc);
                if (param2)
                {
                    this.img.width = param2;
                }
                if (param3)
                {
                    this.img.width = param3;
                }
            }
            return;
        }// end function

        protected function completeFunc(param1:BitmapData) : void
        {
            var _loc_2:* = null;
            this.img.setSize(40, 40);
            if (this._info is PropInfo)
            {
                _loc_2 = PropUtil.getQualityColor(this._info as PropInfo);
                if (_loc_2 != "")
                {
                    if (!this.qualityEffect)
                    {
                        this.qualityEffect = new VMCView();
                        this.qualityEffect.auto = true;
                        this.qualityEffect.updatePose("90", true);
                        this.qualityEffect.move(20 + this.img.x, 20 + this.img.y);
                        addChild(this.qualityEffect);
                    }
                    this.qualityEffect.loadRes("res/effect/40/" + _loc_2 + ".png");
                }
            }
            if (this._info is PropInfo && this._info.isbind && this.img.height != 0 && this._lockImg)
            {
                this._lockImg.x = this.img.x + 2;
                this._lockImg.y = this.img.y + this.img.height - this._lockImg.height;
                addChild(this._lockImg);
            }
            else if (this._lockImg && this._lockImg.parent)
            {
                this._lockImg.parent.removeChild(this._lockImg);
            }
            return;
        }// end function

        public function toolTip(param1:String) : void
        {
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            if (this._info != param1)
            {
                this._info = param1;
                if (this._info is MoneyInfo)
                {
                    if (this._lockImg && this._lockImg.parent)
                    {
                        this._lockImg.parent.removeChild(this._lockImg);
                    }
                    if (this._info.url != this.img.url)
                    {
                        this.img.load(this._info.url, this.completeFunc);
                    }
                    ItemTips.create(this, this._info, MoneyTips);
                }
                else
                {
                    this.setInfo(this._info);
                }
            }
            return;
        }// end function

        public function setInfo(param1:Object, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            this._info = param1 as PropInfo;
            this._info.q_kind = Params.SHOW;
            if (this._info)
            {
                if (this._info.url != this.img.url || param2)
                {
                    this.img.load(this._info.url, this.completeFunc);
                }
                _loc_3 = new Object();
                if (this._info.itemModelId == -1)
                {
                    _loc_3.type = 1;
                    _loc_3.num = this._info.num;
                    _loc_3.itemModelId = -1;
                    ItemTips.create(this, _loc_3, CurrencyTips);
                }
                else if (this._info.itemModelId == -2)
                {
                    _loc_3.type = 2;
                    _loc_3.itemModelId = -2;
                    _loc_3.num = this._info.num;
                    ItemTips.create(this, _loc_3, CurrencyTips);
                }
                else if (this._info is EquipmentInfo)
                {
                    ItemTips.create(this, this._info, EquipTips);
                }
                else
                {
                    ItemTips.create(this, this._info, PropTips);
                }
                if (this._lockImg == null)
                {
                    this._lockImg = ToolKit.getNewDO("bindIcon") as Bitmap;
                }
                if (this._info.isbind && this.img.height != 0)
                {
                    this._lockImg.x = this.img.x + 2;
                    this._lockImg.y = this.img.y + this.img.height - this._lockImg.height;
                    addChild(this._lockImg);
                }
                else if (this._lockImg && this._lockImg.parent)
                {
                    this._lockImg.parent.removeChild(this._lockImg);
                }
            }
            else
            {
                if (this._lockImg && this._lockImg.parent)
                {
                    this._lockImg.parent.removeChild(this._lockImg);
                }
                ItemTips.dispose(this);
                this.img.dispose();
            }
            return;
        }// end function

    }
}
