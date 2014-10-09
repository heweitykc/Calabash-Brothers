package com.game.fight.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.vmc.*;
    import com.game.map.bean.*;
    import com.greensock.*;
    import com.model.vo.*;
    import flash.events.*;

    public class SkillBrainStormView extends BaseSprite
    {
        private var _effect:EffectInfo;
        private var _skillInfo:SkillInfo;
        private var count:int = 0;

        public function SkillBrainStormView()
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function showSkill(param1:EffectInfo) : void
        {
            this._effect = param1;
            this._skillInfo = SkillCfgObj.getInstance().getSkillInfoById(param1.effectModelId);
            this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        public function removeSkill() : void
        {
            this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        protected function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = (this.count + 1) % 100;
            this.count = (this.count + 1) % 100;
            if (_loc_2 % 4 == 1)
            {
                VMCManager.addRes(this._skillInfo.hitGroundURL, this.doShowSkill);
            }
            return;
        }// end function

        private function doShowSkill() : void
        {
            if (!this._skillInfo)
            {
                return;
            }
            var _loc_1:* = new VMCView();
            _loc_1.auto = true;
            _loc_1.url = this._skillInfo.hitGroundURL;
            _loc_1.updatePose("90", false, false, true, true);
            _loc_1.move((Math.random() - 0.5) * 450, (Math.random() - 0.5) * 350);
            this.addChild(_loc_1);
            return;
        }// end function

        override public function finalize() : void
        {
            TweenLite.delayedCall(1, this.removeThis);
            this.removeSkill();
            this._effect = null;
            this._skillInfo = null;
            return;
        }// end function

        private function removeThis() : void
        {
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            super.finalize();
            return;
        }// end function

        public function get effect() : EffectInfo
        {
            return this._effect;
        }// end function

    }
}
