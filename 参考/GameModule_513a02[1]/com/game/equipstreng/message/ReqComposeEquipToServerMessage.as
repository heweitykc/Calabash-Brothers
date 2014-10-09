package com.game.equipstreng.message
{
    import __AS3__.vec.*;
    import com.game.equipstreng.message.bean.*;
    import net.*;

    public class ReqComposeEquipToServerMessage extends Message
    {
        private var _compose_id:int;
        private var _type:int;
        private var _equip_ids:Vector.<long>;
        private var _materials:Vector.<ComposeAddInfo>;

        public function ReqComposeEquipToServerMessage()
        {
            this._materials = new Vector.<ComposeAddInfo>;
            return;
        }// end function

        public function set compose_id(param1:int) : void
        {
            this._compose_id = param1;
            return;
        }// end function

        public function get compose_id() : int
        {
            return this._compose_id;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set equip_ids(param1:Vector.<long>) : void
        {
            this._equip_ids = param1;
            return;
        }// end function

        public function get equip_ids() : Vector.<long>
        {
            return this._equip_ids;
        }// end function

        public function set materials(param1:Vector.<ComposeAddInfo>) : void
        {
            this._materials = param1;
            return;
        }// end function

        public function get materials() : Vector.<ComposeAddInfo>
        {
            return this._materials;
        }// end function

        override public function getId() : int
        {
            return 103893;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._compose_id);
            writeByte(this._type);
            writeShort(this._equip_ids.length);
            _loc_1 = 0;
            while (_loc_1 < this._equip_ids.length)
            {
                
                writeLong(this._equip_ids[_loc_1]);
                _loc_1++;
            }
            writeShort(this._materials.length);
            _loc_1 = 0;
            while (_loc_1 < this._materials.length)
            {
                
                writeBean(this._materials[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._compose_id = readInt();
            this._type = readByte();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._equip_ids[_loc_2] = readLong();
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._materials[_loc_2] = readBean(ComposeAddInfo) as ComposeAddInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
