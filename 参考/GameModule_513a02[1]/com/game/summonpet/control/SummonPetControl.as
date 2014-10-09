package com.game.summonpet.control
{
    import com.adobe.serialization.json.*;
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.pet.message.*;
    import com.game.summonpet.message.*;
    import com.game.summonpet.protocol.*;
    import com.model.*;
    import interfaces.role.*;

    public class SummonPetControl extends Object
    {
        private var _protocal:SummonPetProtocol;
        private static var instance:SummonPetControl;

        public function SummonPetControl()
        {
            this._protocal = new SummonPetProtocol();
            return;
        }// end function

        public function summonPetAddHandler(param1:ResSummonPetAddMessage) : void
        {
            Log.log("召唤出怪物");
            return;
        }// end function

        public function summonPetDieHandler(param1:ResSummonPetDieMessage) : void
        {
            Log.log("召唤物死亡");
            MapControl.getInstance().summonPetDie(param1.pet);
            return;
        }// end function

        public function roundSummonPetDisappearHandler(param1:ResRoundSummonPetDisappearMessage) : void
        {
            Log.log("召唤物消失");
            MapControl.getInstance().removeRolesByPersonIDs(param1.petIds);
            return;
        }// end function

        public function summonPetStopHandler(param1:ResSummonPetStopMessage) : void
        {
            MapControl.getInstance().roleStopHandler(param1.petId, param1.position, param1.mapModelId);
            return;
        }// end function

        public function summonPetTranMoveHandler(param1:ResSummonPetTranMoveMessage) : void
        {
            Log.log("召唤怪传送");
            MapControl.getInstance().roleStopHandler(param1.petId, param1.position, param1.mapModelId);
            return;
        }// end function

        public function roundSummonPetHandler(param1:ResRoundSummonPetMessage) : void
        {
            MapControl.getInstance().addSummonPetByCSInfo(param1.pet);
            return;
        }// end function

        public function summonPetRunPositionsHandler(param1:ResSummonPetRunPositionsMessage) : void
        {
            MapControl.getInstance().summonpetPositionsHandler(param1);
            return;
        }// end function

        public function summonPetAttributeChangeHandler(param1:ResSummonPetAttributeChangeMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.summonpetId);
            if (_loc_2)
            {
                _loc_2.info.setAttributte(param1.attributeChange);
            }
            return;
        }// end function

        public function petChatHandler(param1:ResPetChatMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.petId);
            var _loc_3:* = JSON.decode(param1.saycontent);
            return;
        }// end function

        public static function getInstance() : SummonPetControl
        {
            if (instance == null)
            {
                instance = new SummonPetControl;
            }
            return instance;
        }// end function

    }
}
