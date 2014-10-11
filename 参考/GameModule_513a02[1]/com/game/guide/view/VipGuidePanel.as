package com.game.guide.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.backpack.control.*;
    import com.game.backpack.model.*;
    import com.game.clickstream.*;
    import com.game.guide.control.*;
    import com.game.task.*;
    import com.game.vip.control.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;

    public class VipGuidePanel extends BaseBox
    {
        private var _layoutInfo:LayoutInfo;
        private var _viewType:int;
        private var _title:MovieClip;
        private var expBtn:BaseButton;
        private var getBtn:BaseButton;

        public function VipGuidePanel()
        {
            setWH(712, 396);
            loadDisplay("res/vipguide.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("vip_guide_panel");
            this.initUI();
            this.updateView();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.expBtn = new BaseButton(getDisplayChildByName("okBtn1"));
            this.getBtn = new BaseButton(getDisplayChildByName("okBtn2"));
            this._title = getDisplayChildByName("title") as MovieClip;
            this.addListener();
            return;
        }// end function

        private function delayClick() : void
        {
            if (this.expBtn)
            {
                this.expBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (!this._layoutInfo)
            {
                this._layoutInfo = new LayoutInfo(Layout.CENTER);
            }
            Layout.layoutMC(FrameworkGlobal.stage, this, Layout.CENTER);
            FrameworkGlobal.stage.addChild(this);
            this.updateView();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            if (this.getBtn)
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this.getBtn);
                ButtonFlickerControl.getInstance().removeButtonFlicker(this.expBtn);
            }
            TweenLite.killDelayedCallsTo(this.delayClick);
            if (FrameworkGlobal.stage.contains(this))
            {
                FrameworkGlobal.stage.removeChild(this);
            }
            return;
        }// end function

        private function updateView() : void
        {
            if (UILoaded)
            {
                switch(this._viewType)
                {
                    case 0:
                    {
                        this._title.gotoAndStop(1);
                        this.expBtn.visible = true;
                        this.getBtn.visible = false;
                        ButtonFlickerControl.getInstance().addButtonFlicker(this.expBtn);
                        TweenLite.delayedCall(TaskGlobal.AUTO_VIP_GUIDE_CLICK, this.delayClick);
                        break;
                    }
                    case 1:
                    {
                        this._title.gotoAndStop(2);
                        this.expBtn.visible = false;
                        this.getBtn.visible = true;
                        ButtonFlickerControl.getInstance().addButtonFlicker(this.getBtn);
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

        public function get viewType() : int
        {
            return this._viewType;
        }// end function

        public function set viewType(param1:int) : void
        {
            this._viewType = param1;
            return;
        }// end function

        private function addListener() : void
        {
            if (UILoaded)
            {
                this.expBtn.addEventListener(MouseEvent.CLICK, this.__clickHandler);
                this.getBtn.addEventListener(MouseEvent.CLICK, this.__clickHandler);
            }
            return;
        }// end function

        private function __clickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.currentTarget)
            {
                case this.expBtn:
                {
                    _loc_2 = BackpackObj.getInstance().getItemByItemModelId(Params.VIP_EXP_ITEM_ID);
                    if (_loc_2)
                    {
                        BackPackControl.getInstance().useItem(_loc_2, 1);
                    }
                    this.close();
                    break;
                }
                case this.getBtn:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    ClickStream.add(ClickStreamId.CLICK_VipTiYan_LiJiXuFei);
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
