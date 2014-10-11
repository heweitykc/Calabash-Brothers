package net
{
    import com.game.utils.*;
    import flash.utils.*;

    public class Bean extends Object
    {
        private var buf:ByteArray;

        public function Bean()
        {
            return;
        }// end function

        public function getBuf() : ByteArray
        {
            return this.buf;
        }// end function

        public function setBuf(param1:ByteArray) : void
        {
            this.buf = param1;
            return;
        }// end function

        protected function writeInt(param1:int) : void
        {
            this.buf.writeInt(param1);
            return;
        }// end function

        protected function writeString(param1:String) : void
        {
            if (param1 == null)
            {
                this.buf.writeShort(0);
                return;
            }
            this.buf.writeUTF(param1);
            return;
        }// end function

        protected function writeLong(param1:long) : void
        {
            this.buf.writeInt(param1.high);
            this.buf.writeUnsignedInt(param1.low);
            return;
        }// end function

        protected function readLong() : long
        {
            var _loc_1:* = new long();
            _loc_1.high = this.buf.readInt();
            _loc_1.low = this.buf.readInt();
            return _loc_1;
        }// end function

        protected function writeBean(param1:Bean) : void
        {
            param1.write();
            this.buf.writeBytes(param1.buf);
            return;
        }// end function

        protected function writeShort(param1:int) : void
        {
            this.buf.writeShort(param1);
            return;
        }// end function

        protected function writeByte(param1:int) : void
        {
            this.buf.writeByte(param1);
            return;
        }// end function

        protected function readInt() : int
        {
            return this.buf.readInt();
        }// end function

        protected function readString() : String
        {
            return this.buf.readUTF();
        }// end function

        protected function readBean(param1:Class) : Bean
        {
            var _loc_2:* = new param1;
            _loc_2.buf = this.buf;
            _loc_2.reading();
            return _loc_2;
        }// end function

        protected function readShort() : int
        {
            return this.buf.readShort();
        }// end function

        protected function readByte() : uint
        {
            return this.buf.readByte();
        }// end function

        public function getId() : int
        {
            return 0;
        }// end function

        protected function writing() : Boolean
        {
            return false;
        }// end function

        protected function reading() : Boolean
        {
            return false;
        }// end function

        public function read(param1:ByteArray) : void
        {
            this.buf = param1;
            this.reading();
            this.clear();
            return;
        }// end function

        public function write() : void
        {
            this.buf = new ByteArray();
            this.writing();
            return;
        }// end function

        public function clear() : void
        {
            this.buf.clear();
            this.buf = null;
            return;
        }// end function

    }
}
