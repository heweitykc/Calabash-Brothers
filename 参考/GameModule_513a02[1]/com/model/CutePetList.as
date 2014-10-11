package com.model
{
    import com.events.*;
    import com.f1.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class CutePetList extends Object
    {
        private var _playerCutePet:ICutePet;
        private var _pets:Dictionary;
        private static var instance:CutePetList;

        public function CutePetList()
        {
            return;
        }// end function

        public function reset() : void
        {
            this._pets = new Dictionary();
            return;
        }// end function

        public function addCutePet(param1:ICutePet) : void
        {
            if (param1)
            {
                this._pets[CutePetInfo(param1.info).parentId.toString()] = param1;
            }
            return;
        }// end function

        public function removeCutePet(param1:ICutePet) : void
        {
            if (!param1)
            {
                return;
            }
            if (param1 == this._playerCutePet)
            {
                this.playerCutePet = null;
            }
            this._pets[param1.info.personId.toString()] = null;
            delete this._pets[param1.info.personId.toString()];
            return;
        }// end function

        public function getCutePet(param1:long) : ICutePet
        {
            return this._pets[param1.toString()];
        }// end function

        public function get playerCutePet() : ICutePet
        {
            return this._playerCutePet;
        }// end function

        public function set playerCutePet(param1:ICutePet) : void
        {
            this._playerCutePet = param1;
            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.PLAYER_CUTE_PET_STATE_UPDATE));
            return;
        }// end function

        public static function getInstance() : CutePetList
        {
            if (instance == null)
            {
                instance = new CutePetList;
            }
            return instance;
        }// end function

    }
}
