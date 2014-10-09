package com.game.equipstreng.view
{
    import com.f1.*;
    import com.f1.vmc.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.text.*;

    public class EquipImage extends BaseSprite
    {
        private var strengthEffect:VMCView;
        private var _url:String;
        private var _image:IconItem;
        private var _info:Object;
        private var _bindSign:TextField;

        public function EquipImage()
        {
            this._image = new IconItem("");
            addChild(this._image);
            this._bindSign = new TextField();
            this._bindSign.width = 56;
            this._bindSign.height = 16;
            this._bindSign.x = this._image.x;
            this._bindSign.y = this._image.y + 40;
            this._bindSign.text = LanguageCfgObj.getInstance().getByIndex("10620");
            var _loc_1:* = new TextFormat();
            _loc_1.font = "SimSun";
            _loc_1.size = 12;
            _loc_1.color = 16711680;
            _loc_1.align = "right";
            this._bindSign.setTextFormat(_loc_1);
            addChild(this._bindSign);
            this._bindSign.visible = false;
            this.strengthEffect = new VMCView();
            this.strengthEffect.auto = true;
            this.strengthEffect.updatePose("90", true);
            addChild(this.strengthEffect);
            return;
        }// end function

        public function set bind(param1:Boolean) : void
        {
            this._bindSign.visible = param1;
            return;
        }// end function

        public function get info()
        {
            return this._info;
        }// end function

        public function setInfo(param1:Object, param2:Boolean = false, param3:String = "", param4:int = 56, param5:int = 56, param6:int = 0) : void
        {
            this._info = param1;
            if (this._info)
            {
                if (this._info.url || param2)
                {
                    this._image.setWH(param4, param5);
                    this._image.setImageSize(param4, param5);
                    this._image.setInfo(this._info);
                    if (param3)
                    {
                        this.strengthEffect.loadRes(param3);
                        this.strengthEffect.auto = true;
                        this.strengthEffect.move(param4 / 2, param5 / 2 + param6);
                    }
                    else
                    {
                        this.strengthEffect.finalize();
                    }
                }
                if (this._info is EquipmentInfo)
                {
                    ItemTips.create(this, this._info, EquipTips);
                }
                else
                {
                    ItemTips.create(this, this._info, PropTips);
                }
            }
            else
            {
                ItemTips.dispose(this);
                this._image.setInfo(null);
                this.strengthEffect.finalize();
                if (this._bindSign)
                {
                    this._bindSign.visible = false;
                }
            }
            return;
        }// end function

        public function get image() : IconItem
        {
            return this._image;
        }// end function

    }
}
