package com.game.artifact.handler
{
    import com.game.artifact.control.*;
    import com.game.artifact.message.*;
    import net.*;

    public class ResRemoldArtifactHandler extends Handler
    {

        public function ResRemoldArtifactHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            ArtifactControl.getInstance().resRemoldArtifact(message as ResRemoldArtifactMessage);
            return;
        }// end function

    }
}
