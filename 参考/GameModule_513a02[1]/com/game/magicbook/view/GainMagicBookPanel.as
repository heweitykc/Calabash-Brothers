package com.game.magicbook.view
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.magicbook.control.*;
    import com.game.magicbook.model.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GainMagicBookPanel extends BaseBox
    {
        private var _btnClose:BaseButton;
        private var _getRewardBtn:BaseButton;
        private var _rechargeBtn:BaseButton;
        private var _video:MovieClip;
        private var _config:QMagicBookCfg;
        private static var swf:String = "res/gainmagicbook.swf";

        public function GainMagicBookPanel()
        {
            this._config = QMagicbookLevelCfg.getInstance().getMagicBookCfg(1);
            loadDisplay(swf);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("gainmagicbook_main");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this._getRewardBtn = new BaseButton(getDisplayChildByName("getRewardBtn"));
            this._rechargeBtn = new BaseButton(getDisplayChildByName("rechargeBtn"));
            this._video = getDisplayChildByName("video");
            this._video.mask = getDisplayChildByName("gbmask");
            this._video.stop();
            (getDisplayChildByName("attackTxt") as TextField).text = this._config.prop[ItemEffictType.MAGICBOOK_ATTACK_MIN] + " - " + this._config.prop[ItemEffictType.MAGICBOOK_ATTACK_MAX];
            (getDisplayChildByName("speedTxt") as TextField).text = this._config.prop[ItemEffictType.MAGICBOOK_ATTACK_SPEED];
            (getDisplayChildByName("successTxt") as TextField).text = this._config.prop[ItemEffictType.MAGICBOOK_ATTACK_SUCCESS];
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.removeFromStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                case this._getRewardBtn:
                {
                    MagicBookControl.getIntance().reqGainBook();
                    break;
                }
                case this._rechargeBtn:
                {
                    JSTools.openWindow(Params.officialRechargeWebSite);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            this.__updateBtnState();
            this._video.play();
            MagicBookData.addEventListener(MagicBookData.STATE_CHANGE, this.__updateBtnState);
            return;
        }// end function

        private function __updateBtnState(event:Event = null) : void
        {
            if (MagicBookData.state == 1)
            {
                this._getRewardBtn.visible = true;
                this._rechargeBtn.visible = false;
            }
            else
            {
                this._getRewardBtn.visible = false;
                this._rechargeBtn.visible = true;
            }
            return;
        }// end function

        private function removeFromStage(event:Event) : void
        {
            this._video.stop();
            return;
        }// end function

    }
}
