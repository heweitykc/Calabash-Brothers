package interfaces.net
{
    import net.*;

    public interface IMessagePool
    {

        public function IMessagePool();

        function getMessage(param1:int) : Message;

        function getHandler(param1:int) : Handler;

    }
}
