package com.game.vipcopy.view
{
    import avmplus.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import flash.events.*;

    public class VipCopyBox extends BaseBox
    {
        private var _vipBossView:VipBossView;
        private var _vipEnterCopyView:VipEnterCopyView;
        private var viewArray:Array;
        private var closeBtn:BaseButton;
        private var _type:int = 1;

        public function VipCopyBox()
        {
            this.viewArray = [];
            loadDisplay("res/vipcopy.swf");
            return;
        }// end function

        public function get vipBossView() : VipBossView
        {
            if (!this._vipBossView)
            {
                this._vipBossView = new VipBossView();
                addChild(this._vipBossView);
                this.viewArray[0] = this._vipBossView;
            }
            return this._vipBossView;
        }// end function

        public function get vipEnterCopyView() : VipEnterCopyView
        {
            if (!this._vipEnterCopyView)
            {
                this._vipEnterCopyView = new VipEnterCopyView();
                addChild(this._vipEnterCopyView);
                this.viewArray[1] = this._vipEnterCopyView;
            }
            return this._vipEnterCopyView;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("vipCopyPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.choose(1);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            if (this.vipEnterCopyView && this.vipEnterCopyView.vipCopyNestDrop)
            {
                this.vipEnterCopyView.vipCopyNestDrop.close();
            }
            super.close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            return;
        }// end function

        override public function close() : void
        {
            if (this.vipEnterCopyView && this.vipEnterCopyView.vipCopyNestDrop)
            {
                this.vipEnterCopyView.vipCopyNestDrop.close();
            }
            super.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.choose(1);
            }
            return;
        }// end function

        public function choose(param1:int = 1) : void
        {
            switch(param1)
            {
                case 1:
                {
                    if (this._vipEnterCopyView)
                    {
                        this._vipEnterCopyView.visible = false;
                    }
                    if (this._vipBossView)
                    {
                        this._vipBossView.visible = true;
                    }
                    this.vipBossView.update();
                    break;
                }
                case 2:
                {
                    this.vipEnterCopyView.update();
                    if (this._vipEnterCopyView)
                    {
                        this._vipEnterCopyView.visible = true;
                    }
                    if (this._vipBossView)
                    {
                        this._vipBossView.visible = false;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

    }
}
