package com.game.autopk.mediator
{
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class SkillBoxItemMediator extends EventDispatcher
    {
        public var btn:BaseButton;
        public var label:TextField;
        public var img:Image;
        private var _skin:MovieClip;
        private var _data:SkillInfo;

        public function SkillBoxItemMediator(param1:MovieClip, param2:int)
        {
            this._skin = param1;
            this.btn = new BaseButton(param1.getChildByName("btn"));
            this.btn.visible = false;
            this.label = param1.getChildByName("txt") as TextField;
            this.label.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11895"), [param2]);
            var _loc_3:* = param1.getChildByName("container") as MovieClip;
            _loc_3.removeChildAt(0);
            this.img = new Image();
            this.img.setSize(52, 52);
            _loc_3.addChild(this.img);
            this._skin.addEventListener(MouseEvent.CLICK, this.onClickHandle);
            this._skin.addEventListener("rightClick", this.onClickHandle);
            return;
        }// end function

        public function set data(param1:SkillInfo) : void
        {
            this._data = param1;
            if (this._data)
            {
                this.img.load(this._data.iconUrl, this.completeHandle);
                ItemTips.create(this._skin, this._data, SkillTips);
            }
            else
            {
                this.img.dispose();
                ItemTips.dispose(this._skin);
            }
            return;
        }// end function

        private function completeHandle(param1:BitmapData) : void
        {
            this.img.setSize(52, 52);
            return;
        }// end function

        public function get data() : SkillInfo
        {
            return this._data;
        }// end function

        public function get skin() : MovieClip
        {
            return this._skin;
        }// end function

        private function onClickHandle(event:MouseEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

    }
}
