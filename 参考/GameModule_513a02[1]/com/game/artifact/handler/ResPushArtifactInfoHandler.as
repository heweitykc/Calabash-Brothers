package com.game.artifact.handler
{
    import com.game.artifact.control.*;
    import com.game.artifact.message.*;
    import net.*;

    public class ResPushArtifactInfoHandler extends Handler
    {

        public function ResPushArtifactInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            ArtifactControl.getInstance().resPushArtifactInfo(message as ResPushArtifactInfoMessage);
            return;
        }// end function

    }
}
