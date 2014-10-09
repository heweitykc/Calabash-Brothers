package com.game.grandMasterPanel.handler
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.utils.*;
    import com.game.fight.control.*;
    import com.game.masterskill.message.*;
    import com.model.*;
    import com.model.vo.*;
    import interfaces.role.*;
    import net.*;

    public class ResTouchMasterSkillHandler extends Handler
    {

        public function ResTouchMasterSkillHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_6:* = null;
            var _loc_1:* = ResTouchMasterSkillMessage(message);
            var _loc_2:* = MasterSkillObj.instance.getInfoByIdAndLevel(_loc_1.masterSkillID, _loc_1.masterSkillLevel);
            var _loc_3:* = UserObj.getInstance().playerInfo;
            if (!_loc_2)
            {
                return;
            }
            var _loc_4:* = RoleList.getInstance().getRole(_loc_1.sourceId);
            var _loc_5:* = RoleList.getInstance().getRole(_loc_1.targetId);
            if (_loc_3 && _loc_3.personId && _loc_3.personId.equal(_loc_1.sourceId))
            {
                Global.popManager.addedToFight(_loc_2.q_use_word);
            }
            else if (_loc_4 && _loc_4.info)
            {
                Global.popManager.addedToFight(StringUtil.formatString(_loc_2.q_hit_word, _loc_4.info.name));
            }
            if (_loc_4 && _loc_5)
            {
                _loc_6 = _loc_2.skillInfo;
                _loc_6.targetRole = _loc_5;
                FightControl.getInstance().showSkillRelease(_loc_4, _loc_6);
            }
            return;
        }// end function

    }
}
