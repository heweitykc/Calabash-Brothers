package com.game.summonpet.view
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.ui.box.*;
    import com.f1.ui.image.*;
    import com.f1.ui.stripe.*;
    import com.model.vo.*;
    import flash.text.*;

    public class SummonPetPanel extends BaseBox
    {
        private var _stripe:Stripe;
        private var _headIcon:Image;
        private var _txtName:TextField;
        private var _info:MonsterInfo;

        public function SummonPetPanel()
        {
            loadDisplay("res/summonpet.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("summon_pet_panel", 0);
            this.initUI();
            this.updateUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._stripe = new Stripe(getDisplayChildByName("blood_stripe"));
            this._headIcon = new Image();
            this._headIcon.move(3, 3);
            addChild(this._headIcon);
            this._txtName = TextField(getDisplayChildByName("name_txt"));
            return;
        }// end function

        public function set info(param1:MonsterInfo) : void
        {
            this._info = param1;
            this._info.addEvtListener(RoleEvent.UPDATE_HP, this.__changeHP);
            if (UILoaded)
            {
                this.updateUI();
            }
            return;
        }// end function

        private function __changeHP(event:RoleEvent) : void
        {
            if (UILoaded && this._info)
            {
                this._stripe.setValue(this._info.HP, this._info.HPMax);
            }
            return;
        }// end function

        public function reset() : void
        {
            if (this._info)
            {
                this._info.removeEvtListener(RoleEvent.UPDATE_HP, this.__changeHP);
                this._info = null;
            }
            return;
        }// end function

        private function updateUI() : void
        {
            var _loc_1:* = this._info.name;
            var _loc_2:* = MonsterCfgObj.getInstance().getMonsterCfg(this._info.cfgId);
            this._txtName.text = _loc_2.q_name;
            this._headIcon.load(this._info.headIcon);
            this._stripe.setValue(this._info.HP, this._info.HPMax);
            return;
        }// end function

    }
}
