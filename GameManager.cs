using Godot;
using System;

public partial class GameManager : Node
{
	public static Spawnpoint spawnpoint;
	// respawn the players at a checkpoint
	public static void respawnPlayer(Player player) {
		if (spawnpoint != null) {
			player.Position = spawnpoint.GlobalPosition;
		}
	}
}
