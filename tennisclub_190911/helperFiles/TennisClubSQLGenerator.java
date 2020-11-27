/**
 * 
 */
package outputGenerators;

import java.util.Random;

/**
 * @author Hannes Alkin
 * @version
 * @since 12.09.2019
 * 
 */
public class TennisClubSQLGenerator {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		Random ran = new Random();

		for (int i = 0; i < 400; i++) {

			int player_id = ran.nextInt(250) + 1;
			// game_opponent is drawn from the opponentNames list. ' is escaped, e.g. in "D'Estaing"
			String game_opponent = opponentNames[i].replace("'","\\'");
			int comp_id = (i % 10) + 1;
			/*-
			 * Number of sets is always four 
			 * 50% of games are finished, i.e. sets_won + sets_lost = sets_total
			 * for the others, sets_won + sets_lost is a random num between 0 and sets_total
			 */
			int sets_total = 4;
			int sets_won = 0;
			int sets_lost = 0;
			int sets_played = 0;
			if (ran.nextBoolean()) {
				sets_played = sets_total;
			} else {
				sets_played = ran.nextInt(sets_total);
			}
			sets_won = ran.nextInt(sets_played + 1);
			sets_lost = sets_played - sets_won;

			System.out
					.println("Insert into game (player_id, game_opponent, comp_id, sets, sets_won, sets_lost) values ("
							+ player_id + ", \'" + game_opponent + "\', " + comp_id + ", " + sets_total + ", "
							+ sets_won + ", " + sets_lost + ");");
		} // end of loop

	} // end of main

	static String[] opponentNames = { "Lecordier", "Peal", "Vuittet", "Byars", "Kenewell", "Guilloneau", "Eschelle",
			"Lesper", "Galer", "Hatliffe", "Horsey", "Folks", "Gallant", "Shipp", "Ladley", "Vannini", "Grimley",
			"Taft", "Eustes", "Lambourn", "Barritt", "Hartburn", "Wenden", "Faloon", "Riha", "Tocknell", "Bickley",
			"Cutmere", "Otteridge", "Gateshill", "Ferfulle", "Bugbird", "Purcer", "Le Frank", "Smeeth", "Wrate",
			"Pinckney", "Anglin", "Detoc", "Shortall", "Matchitt", "Schulter", "Tern", "Fatharly", "Saffe", "Dykes",
			"Welbeck", "MacHostie", "Mahy", "Baike", "Quinton", "Van Oort", "Binham", "Haily", "MacVagh", "Hasty",
			"Culham", "Wardall", "Matasov", "Gaize", "Sawkin", "Lanning", "Mousdall", "Culshew", "Cohn", "Butterwick",
			"Rosendahl", "Drillingcourt", "Everall", "Clever", "Gruby", "Serjeantson", "Joska", "Humberstone",
			"Kellington", "Westbury", "Ashburne", "Wessel", "Cardenas", "Briance", "Stolte", "Everall", "Friberg",
			"Blakemore", "Colegate", "McGurn", "Sarah", "Frunks", "Gretton", "Nayshe", "Lentsch", "Zorro", "Dunbleton",
			"Cosslett", "Caldero", "Degoy", "Verrier", "Strettle", "Armiger", "Eaken", "Maggill'Andreis", "Fenne",
			"Ghione", "Buglar", "Redmayne", "Gosker", "Hundley", "Durtnel", "Cumbes", "Rabbitts", "Zanuciolii",
			"Sparhawk", "Schimek", "Hugonnet", "Dockrell", "Bibby", "O'Gorman", "Haws", "Tape", "Malter", "Renton",
			"Gillani", "Hayzer", "Derye-Barrett", "Backler", "Hartop", "Cominetti", "Ennever", "Matus", "Lanchbery",
			"Queripel", "Switland", "Kidde", "Koppeck", "Dorin", "Tafani", "Gorelli", "Lanfranconi", "Leving",
			"Oloshkin", "Fathers", "Corner", "Frankema", "Sannes", "Stanbrooke", "Treweela", "Hinckes", "Imort",
			"Crumly", "Brasseur", "Swaisland", "Cressar", "Rablan", "Ferencowicz", "Satch", "Durbridge", "Risborough",
			"Poytheras", "Cristofor", "Astall", "Spurdens", "Hambling", "Morrilly", "Whitwam", "Heibl", "Yarrell",
			"Yukhtin", "Sheppey", "Flieger", "Wales", "Sansun", "Wearne", "Codrington", "Servis", "Maffione", "Blois",
			"Hawke", "Klees", "Foster", "Sybe", "Vizor", "Vernall", "Pagram", "Reckus", "Allden", "Gallegos", "Fucher",
			"Headey", "Diglin", "Edgworth", "Gosnall", "Seer", "Simione", "Mc Corley", "Cobbold", "Bartusek", "Elliss",
			"Sowersby", "Behling", "Truder", "Cobbledick", "Webling", "Gathercoal", "Le Guin", "Rigbye", "Virgoe",
			"Durie", "Perfect", "Punchard", "Hegdonne", "Clears", "Fairfoul", "Davoren", "Gorusso", "Ollin", "Foulks",
			"Sinnock", "Elcox", "Mcasparan", "Sueter", "Lissaman", "Huburn", "Cleghorn", "Dutch", "Broseke", "Claiton",
			"Alltimes", "McCook", "Mahaddy", "Lowson", "Pervew", "Cyples", "Bakeup", "Francescoccio", "Beebee",
			"Osipenko", "Wheater", "Castles", "Harome", "Garlicke", "Mitchenson", "Samsin", "Ulrik", "Brear",
			"Muspratt", "L'argent", "De Ruggero", "Mackett", "Sterrie", "Witherop", "Dendle", "McVane", "Wigglesworth",
			"Martyn", "Tredwell", "Grigorey", "Kopf", "Ciotti", "Saltrese", "Szwarc", "Eymer", "Lukacs", "Whaymand",
			"Crayke", "Jaggar", "Juett", "Gatman", "Charte", "Prandin", "Cornner", "Nafziger", "Raun", "Vowels",
			"Emmines", "Bispham", "Pattillo", "Segot", "Idel", "Joanaud", "Bleasby", "Ricards", "Graysmark", "Glazyer",
			"Gallard", "Brightie", "Twentyman", "Eisold", "Melton", "Melchior", "Woodier", "Heenan", "Ridings",
			"McCroary", "Aslott", "Davage", "O'Breen", "Maith", "Martyn", "Seers", "Eden", "Couroy", "Littrell",
			"MacGeffen", "Grasha", "Todhunter", "Darrigrand", "Disney", "Hazael", "Boldra", "Mackie", "Kwietek", "Wise",
			"Bourne", "Skerritt", "Purvess", "Tevelov", "Hainey", "Cordey", "Lippard", "Snel", "Ratke", "Dripps",
			"Alster", "Raffin", "Blankhorn", "Dimblebee", "Luparto", "Denmead", "Fairs", "Quested", "Kloisner",
			"Airlie", "Bohl", "Gregh", "Bunnell", "Tregenza", "Attenbarrow", "Slucock", "Sheaf", "Henken", "Pedican",
			"L'argent", "Bellerby", "Stoute", "Bayston", "Segrott", "Meech", "Ickovicz", "Crayker", "Arbon", "Winnett",
			"Follit", "Dadds", "Commander", "Astbury", "Beville", "Eltune", "McMonies", "Carter", "Burlay", "McFarland",
			"Stoaks", "Brownlee", "Seres", "Heaslip", "Besson", "Rathborne", "Masser", "Cowdrey", "Kynaston", "Quinney",
			"Dutnell", "Wilshaw", "Fairweather", "Haruard", "Durno", "Kendle", "Bolitho", "Brass", "Lovemore", "Edney",
			"Aloway", "Gilroy", "Bosley", "Bras", "Gong", "Arnaudot", "Kurt", "Grimbaldeston", "Di Biasi", "Eton",
			"Prout", "Bamlett", "Summerson", "Schoenrock", "Barkaway", "Allnatt", "Dalbey", "Cardnell", "McGinnell" };

} // end of class
