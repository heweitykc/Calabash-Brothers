package com.game.pet.message
{
    import __AS3__.vec.*;
    import com.game.pet.bean.*;
    import net.*;

    public class ResPetListMessage extends Message
    {
        private var _pets:Vector.<PetDetailInfo>;

        public function ResPetListMessage()
        {
            this._pets = new Vector.<PetDetailInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._pets.length);
            _loc_1 = 0;
            while (_loc_1 < this._pets.length)
            {
                
                writeBean(this._pets[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._pets[_loc_1] = readBean(PetDetailInfo) as PetDetailInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 110101;
        }// end function

        public function get pets() : Vector.<PetDetailInfo>
        {
            return this._pets;
        }// end function

        public function set pets(param1:Vector.<PetDetailInfo>) : void
        {
            this._pets = param1;
            return;
        }// end function

    }
}
