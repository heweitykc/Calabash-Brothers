package com.game.fight.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.vmc.*;
    import com.game.map.bean.*;
    import com.model.vo.*;
    import flash.events.*;

    public class SkillFireSwordView extends BaseSprite
    {
        private var _effect:EffectInfo;
        private var _skillInfo:SkillInfo;
        private var _vmcView1:VMCView;
        private var _vmcView2:VMCView;

        public function SkillFireSwordView()
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function showSkillStep1(param1:EffectInfo) : void
        {
            this._effect = param1;
            this._skillInfo = SkillCfgObj.getInstance().getSkillInfoById(param1.effectModelId);
            this.doShowEffect1();
            return;
        }// end function

        public function showSkillStep2(param1:EffectInfo) : void
        {
            this._effect = param1;
            this._skillInfo = SkillCfgObj.getInstance().getSkillInfoById(param1.effectModelId);
            this.doShowEffect2();
            return;
        }// end function

        private function doShowEffect1() : void
        {
            VMCManager.addRes(this._skillInfo.releaseURL, this.ShowEffect1);
            return;
        }// end function

        private function doShowEffect2() : void
        {
            VMCManager.addRes(this._skillInfo.releaseGroundURL, this.ShowEffect2);
            return;
        }// end function

        private function ShowEffect1() : void
        {
            if (!this._vmcView1)
            {
                this._vmcView1 = new VMCView();
            }
            this._vmcView1.addEventListener(Event.REMOVED_FROM_STAGE, this.skillComplete);
            this._vmcView1.auto = true;
            this._vmcView1.url = this._skillInfo.releaseURL;
            this._vmcView1.updatePose("90", false, false, true);
            if (this._vmcView1.poseInfo.scale > 1)
            {
                this._vmcView1.scale = this._vmcView1.poseInfo.scale;
            }
            this._vmcView1._y = 70 * this._vmcView1.scale;
            addChild(this._vmcView1);
            return;
        }// end function

        protected function skillComplete(event:Event) : void
        {
            if (this._skillInfo)
            {
                return;
            }
            this._vmcView1.removeEventListener(Event.REMOVED_FROM_STAGE, this.skillComplete);
            this._vmcView1 = null;
            VMCManager.addRes(this._skillInfo.releaseGroundURL, this.ShowEffect2);
            return;
        }// end function

        private function ShowEffect2() : void
        {
            if (!this._skillInfo)
            {
                return;
            }
            if (!this._vmcView2)
            {
                this._vmcView2 = new VMCView();
            }
            this._vmcView2.auto = true;
            this._vmcView2.url = this._skillInfo.releaseGroundURL;
            this._vmcView2.updatePose("90", true);
            if (this._vmcView2.poseInfo.scale > 1)
            {
                this._vmcView2.scale = this._vmcView2.poseInfo.scale;
            }
            this._vmcView2._y = 70 * this._vmcView2.scale;
            addChild(this._vmcView2);
            return;
        }// end function

        override public function finalize() : void
        {
            this._effect = null;
            this._skillInfo = null;
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            if (this._vmcView2)
            {
                this._vmcView2.finalize();
            }
            this._vmcView2 = null;
            super.finalize();
            return;
        }// end function

        public function get effect() : EffectInfo
        {
            return this._effect;
        }// end function

        public function set effect(param1:EffectInfo) : void
        {
            this._effect = param1;
            return;
        }// end function

    }
}
