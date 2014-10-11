package com.game.task.message
{
    import net.*;

    public class ReqMainTaskTransMessage extends Message
    {
        public var mapId:int;
        public var x:int;
        public var y:int;
        public var line:int;
        public var type:int;
        public var taskId:int;

        public function ReqMainTaskTransMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 131212;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this.mapId);
            writeInt(this.x);
            writeInt(this.y);
            writeInt(this.line);
            writeByte(this.type);
            writeInt(this.taskId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.mapId = readInt();
            this.x = readInt();
            this.y = readInt();
            this.line = readInt();
            this.type = readByte();
            this.taskId = readInt();
            return true;
        }// end function

    }
}
