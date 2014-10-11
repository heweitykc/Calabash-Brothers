package com.game.player.handler
{
    import com.game.backpack.control.*;
    import com.game.guide.control.*;
    import com.game.player.message.*;
    import com.game.primaryrole.control.*;
    import com.model.*;
    import com.model.vo.*;
    import net.*;

    public class ResAddPointHandler extends Handler
    {

        public function ResAddPointHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangeOneAttributeMessage(this.message);
            var _loc_2:* = UserObj.getInstance().playerInfo;
            var _loc_3:* = _loc_1.intelligence > _loc_2.intelligence || _loc_1.vitality > _loc_2.vitality || _loc_1.strength > _loc_2.strength || _loc_1.agile > _loc_2.agile;
            _loc_2.intelligence = _loc_1.intelligence;
            _loc_2.vitality = _loc_1.vitality;
            _loc_2.strength = _loc_1.strength;
            _loc_2.agile = _loc_1.agile;
            _loc_2.unallocatedTalent = _loc_1.restPlusPoint;
            PrimaryRoleControl.getInstance().addPointRes(_loc_1.endValue);
            var _loc_4:* = UserObj.getInstance().playerInfo;
            if (_loc_2.level > 30 && _loc_4.unallocatedTalent < 25)
            {
                FunGuideControl.getInstance().closeGuide(FunGuideControl.getInstance().TALENT);
            }
            if (_loc_3)
            {
                BackPackControl.getInstance().equipConfirm();
            }
            return;
        }// end function

    }
}
