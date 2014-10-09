package com.game.protect.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.game.guide.control.*;
    import com.game.protect.control.*;
    import com.game.protect.event.*;
    import com.game.protect.model.*;
    import flash.display.*;
    import flash.events.*;

    public class ProtectLockButton extends Component
    {
        private var btnLocked:BaseButton;
        private var btnUnlocked:BaseButton;
        private var protectData:ProtectData;
        private var highlighted:Boolean = false;
        private var visibleChangeCallback:Function;

        public function ProtectLockButton(param1:MovieClip, param2:MovieClip, param3:Function)
        {
            this.protectData = ProtectData.getInstance();
            this.visibleChangeCallback = param3;
            this.btnLocked = new BaseButton(param1);
            this.btnUnlocked = new BaseButton(param2);
            move(this.btnLocked.x, this.btnLocked.y);
            var _loc_4:* = this.btnLocked.parent;
            _loc_4.addChildAt(this, _loc_4.getChildIndex(this.btnLocked));
            this.btnLocked.move(0, 0);
            this.btnUnlocked.move(0, 0);
            addChild(this.btnLocked);
            addChild(this.btnUnlocked);
            this.visible = false;
            addEventListener(MouseEvent.CLICK, this.onClick);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (stage)
            {
                this.onAddedToStage();
            }
            return;
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            this.protectData.addEventListener(ProtectEvent.PROTECT_DATA_CHANGE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.protectData.removeEventListener(ProtectEvent.PROTECT_DATA_CHANGE, this.refreshData);
            this.setHighlighted(false);
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            if (this.protectData.lockEnabled)
            {
                if (!visible)
                {
                    this.visible = true;
                }
            }
            if (visible)
            {
                if (!this.protectData.hasPassword)
                {
                    StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11099"));
                }
                else if (this.protectData.locked)
                {
                    StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11100"));
                }
                else
                {
                    StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11101"));
                }
            }
            this.btnLocked.visible = this.protectData.locked;
            this.btnUnlocked.visible = !this.protectData.locked;
            this.setHighlighted(!this.protectData.hasPassword);
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            this.visibleChangeCallback(param1);
            return;
        }// end function

        private function setHighlighted(param1:Boolean) : void
        {
            if (this.highlighted != param1)
            {
                this.highlighted = param1;
                if (this.highlighted)
                {
                    ButtonFlicker3Control.getInstance().addButtonFlicker(this);
                }
                else
                {
                    ButtonFlicker3Control.getInstance().removeButtonFlicker(this);
                }
            }
            return;
        }// end function

        private function onClick(event:MouseEvent) : void
        {
            ProtectControl.getInstance().changeLockState();
            return;
        }// end function

    }
}
