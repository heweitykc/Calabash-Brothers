package com.game.fight.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ReqAttackSpecialMessage extends Message
    {
        private var _fightTargets:Vector.<long>;
        private var _fightTypes:Vector.<int>;
        private var _fightType:int;
        private var _fightDirection:int;
        private var _mapModelId:int;
        private var _line:int;
        private var _x:int;
        private var _y:int;

        public function ReqAttackSpecialMessage()
        {
            this._fightTargets = new Vector.<long>;
            this._fightTypes = new Vector.<int>;
            return;
        }// end function

        public function get fightTargets() : Vector.<long>
        {
            return this._fightTargets;
        }// end function

        public function set fightTargets(param1:Vector.<long>) : void
        {
            this._fightTargets = param1;
            return;
        }// end function

        public function get fightTypes() : Vector.<int>
        {
            return this._fightTypes;
        }// end function

        public function set fightTypes(param1:Vector.<int>) : void
        {
            this._fightTypes = param1;
            return;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function set x(param1:int) : void
        {
            this._x = param1;
            return;
        }// end function

        public function get line() : int
        {
            return this._line;
        }// end function

        public function set line(param1:int) : void
        {
            this._line = param1;
            return;
        }// end function

        public function get mapModelId() : int
        {
            return this._mapModelId;
        }// end function

        public function set mapModelId(param1:int) : void
        {
            this._mapModelId = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._fightType);
            writeInt(this._fightDirection);
            writeInt(this._mapModelId);
            writeInt(this._line);
            writeShort(this._x);
            writeShort(this._y);
            writeShort(this._fightTargets.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._fightTargets.length)
            {
                
                writeLong(this._fightTargets[_loc_1]);
                _loc_1 = _loc_1 + 1;
            }
            writeShort(this._fightTypes.length);
            _loc_1 = 0;
            while (_loc_1 < this._fightTypes.length)
            {
                
                writeByte(this._fightTypes[_loc_1]);
                _loc_1 = _loc_1 + 1;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fightType = readInt();
            this._fightDirection = readInt();
            this._mapModelId = readInt();
            this._line = readInt();
            this._x = readShort();
            this._y = readShort();
            return true;
        }// end function

        override public function getId() : int
        {
            return 502203;
        }// end function

        public function get fightDirection() : int
        {
            return this._fightDirection;
        }// end function

        public function set fightDirection(param1:int) : void
        {
            this._fightDirection = param1;
            return;
        }// end function

        public function get fightType() : int
        {
            return this._fightType;
        }// end function

        public function set fightType(param1:int) : void
        {
            this._fightType = param1;
            return;
        }// end function

    }
}
