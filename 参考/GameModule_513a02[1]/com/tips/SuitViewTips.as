package com.tips
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.role.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class SuitViewTips extends BaseTips
    {
        private var descTf:TextField;
        private var vmcMc:MovieClip;
        private var _bodyVmc:Role;

        public function SuitViewTips()
        {
            var _loc_1:* = ToolKit.getNew("equipForge.suitTips");
            addChild(_loc_1);
            this.vmcMc = _loc_1.vmcMc;
            this.descTf = _loc_1.descTf;
            this._bodyVmc = new Role();
            this._bodyVmc.auto = true;
            this.vmcMc.addChild(this._bodyVmc);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = param1[0];
            var _loc_3:* = param1[1];
            var _loc_4:* = SuitEffectCfgObj.instance.getSuitEffectByCount(_loc_2, _loc_3);
            if (SuitEffectCfgObj.instance.getSuitEffectByCount(_loc_2, _loc_3))
            {
                this.descTf.text = StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12370"), _loc_3);
                _loc_5 = UserObj.getInstance().playerInfo;
                _loc_6 = new PlayerInfo();
                _loc_6.setRoleInfo(_loc_5.level, _loc_5.avatar, _loc_5.job, _loc_5.armor, _loc_5.weapon, _loc_5.weapon_other, _loc_5.wingInfo);
                _loc_6.personId = new long(_loc_5.personId.low, _loc_5.personId.high);
                _loc_6.roleType = RoleType.ROLE_TYPE_NPC;
                _loc_6.suitEffectCount = _loc_4 ? (1) : (0);
                _loc_6.suitEffectIds = [_loc_4.q_id];
            }
            if (_loc_6)
            {
                this._bodyVmc.info = _loc_6;
            }
            else
            {
                this._bodyVmc.finalize();
            }
            return;
        }// end function

        override public function remove() : void
        {
            super.remove();
            this.finalize();
            return;
        }// end function

        override public function finalize() : void
        {
            this.descTf = null;
            this.vmcMc = null;
            this._bodyVmc.finalize();
            super.finalize();
            return;
        }// end function

    }
}
