package com.game.backpack.view
{
    import avmplus.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.vmc.*;
    import com.game.clickstream.*;
    import com.game.shop.control.*;
    import com.game.utils.*;
    import flash.events.*;
    import flash.geom.*;

    public class BackPackPanel extends BaseBox
    {
        private var _preferential:PreferentialView;
        private var _bagPanel:BackpackView;
        private var _close_btn:BaseButton;
        private var _preferentialPoint:Point;
        private var _params:Array;
        private var _func:Function;
        private var _yanhua:VMCView;

        public function BackPackPanel()
        {
            setWH(379, 540);
            loadDisplay("res/backpackpanel.swf");
            return;
        }// end function

        public function get params() : Array
        {
            return this._params;
        }// end function

        public function set params(param1:Array) : void
        {
            this._params = param1;
            return;
        }// end function

        public function set bagPanel(param1:BackpackView) : void
        {
            this._bagPanel = param1;
            return;
        }// end function

        public function get bagPanel() : BackpackView
        {
            return this._bagPanel;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("backpackpanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function changeToSell() : void
        {
            if (this._bagPanel)
            {
                this._bagPanel.changeToSell();
            }
            else
            {
                this._func = this.changeToSell;
            }
            return;
        }// end function

        public function closeSelectStatus() : void
        {
            this._bagPanel.closeSelectStatus();
            return;
        }// end function

        public function openCellRes(param1:int) : void
        {
            if (this._bagPanel)
            {
                this._bagPanel.openCellRes(param1);
            }
            return;
        }// end function

        public function showOpenItemrenderer() : void
        {
            if (this._bagPanel)
            {
                this._bagPanel.showOpenItemrenderer();
            }
            else
            {
                this._func = this.showOpenItemrenderer;
            }
            return;
        }// end function

        public function lockToBind() : void
        {
            if (this._bagPanel)
            {
                this._bagPanel.lockBind();
            }
            return;
        }// end function

        public function changeToAddedStalls() : void
        {
            if (this._bagPanel)
            {
                this._bagPanel.changeToStalls();
            }
            else
            {
                this._func = this.changeToAddedStalls;
            }
            return;
        }// end function

        public function changeToTranscation() : void
        {
            if (this._bagPanel)
            {
                this._bagPanel.changeToTranscation();
            }
            else
            {
                this._func = this.changeToTranscation;
            }
            return;
        }// end function

        public function openItemChange() : void
        {
            if (this._bagPanel)
            {
                this._bagPanel.openItemChange();
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._bagPanel = new BackpackView(getDisplayChildByName("bag"));
            this._preferential = new PreferentialView(getDisplayChildByName("preferential"));
            this._preferentialPoint = new Point(this._preferential.x, this._preferential.y);
            this._close_btn = new BaseButton(getDisplayChildByName("close_btn1"));
            this._close_btn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._bagPanel.arrangBoxes();
            this._bagPanel.open();
            if (this._func != null)
            {
                if (this._params && this._params.length)
                {
                    this._func.apply(this, this._params);
                }
                else
                {
                    this._func();
                }
                this._func = null;
            }
            return;
        }// end function

        override public function open() : void
        {
            ClickStream.add(ClickStreamId.OPEN_BeiBao);
            super.open();
            if (UILoaded)
            {
                this._bagPanel.open();
            }
            return;
        }// end function

        public function setLock(param1:long, param2:Boolean) : void
        {
            this._bagPanel.setLock(param1, param2);
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            this._bagPanel.close();
            ShopController.getInstance().closeShop();
            return;
        }// end function

        public function visiblePreferential(param1:Boolean = false) : void
        {
            if (!param1)
            {
                if (this._preferential.parent)
                {
                    this._preferential.parent.removeChild(this._preferential);
                }
            }
            else if (this._preferential.parent == null)
            {
                addChild(this._preferential);
                this._preferential.x = this._preferentialPoint.x;
                this._preferential.y = this._preferentialPoint.y;
            }
            return;
        }// end function

        public function releaseLock() : void
        {
            this._bagPanel.releaseLock();
            return;
        }// end function

        public function updateBox() : void
        {
            if (this._bagPanel)
            {
                this._bagPanel.clearUp();
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this._bagPanel.close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            return;
        }// end function

    }
}
