package com.net
{
    import com.game.login.handler.*;
    import com.game.login.message.*;
    import com.game.player.handler.*;
    import com.game.player.message.*;
    import flash.utils.*;
    import interfaces.net.*;
    import net.*;

    public class LoginMessagePool extends Object implements IMessagePool
    {
        private var messages:Dictionary;
        private var handlers:Dictionary;

        public function LoginMessagePool()
        {
            this.messages = new Dictionary();
            this.handlers = new Dictionary();
            this.register(100101, ResCharacterInfosMessage, ResCharacterInfosHandler);
            this.register(100102, ResLoginSuccessMessage, ResLoginSuccessHandler);
            this.register(100103, ResSubstituteMessage, ResSubstituteHandler);
            this.register(100104, ResCreateFailedMessage, ResCreateFailedHandler);
            this.register(100105, ResDeleteSuccessMessage, ResDeleteSuccessHandler);
            this.register(100106, ResLoginFailedMessage, ResLoginFailedHandler);
            this.register(100107, ResQuitMessage, ResQuitHandler);
            this.register(100108, ResHeartMessage, ResHeartHandler);
            this.register(100109, ResDelPlayerStatusToClientMessage, ResDelPlayerStatusToClientHandler);
            this.register(100110, ResCreateUserMessage, ResCreateUserHandler);
            this.register(103121, ResPlayerNonageStateMessage, ResPlayerNonageStateHandler);
            this.register(100314, ResRolesCreateReportToGateMessage, ResRolesCreateReportToGateMessageHandler);
            return;
        }// end function

        private function register(param1:int, param2:Class, param3:Class) : void
        {
            this.messages[param1] = param2;
            this.handlers[param1] = param3;
            return;
        }// end function

        public function getMessage(param1:int) : Message
        {
            if (this.messages[param1] == null)
            {
                return null;
            }
            return new this.messages[param1] as Message;
        }// end function

        public function getHandler(param1:int) : Handler
        {
            if (this.handlers[param1] == null)
            {
                return null;
            }
            return new this.handlers[param1] as Handler;
        }// end function

    }
}
