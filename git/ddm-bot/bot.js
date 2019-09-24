const Eris     =   require('eris');
const auth     =   require('./auth.json');
const config   =   require('./config.json')

var bot = new Eris(auth.token);

bot.on('ready', () => { // ooh erisjs with those modern js syntax
    console.log('ready lol');
});

bot.on('messageCreate', (msg) => {
    var mContent = msg.content;
    var isAdmin = (config.allowList.indexOf(msg.author.id) >= 0)
    console.log(msg.author.id)
    console.log(mContent)
    if (mContent.substring(0, 1) == '~') {
        //bot.createMessage(msg.channel.id, "hello you have called apon the bot");
        var args = mContent.substring(1).split(' ');
        var cmd = args[0];
        args = args.splice(1).join(" ");
        
        switch(cmd) {
            case 'echo':
                bot.createMessage(msg.channel.id, args);
            break;
            case 'welcome':
                sendWelcome(msg.author);
            break;
            case 'help':
                bot.createMessage(msg.channel.id, {
                    embed: {
                        color: 0x1111ff,
                        title: "Help",
                        description: "Commands: \nhelp - get this\necho - repeat what you say\nwelcome - send a nice welcome message"
                    }
                });    
            break;
        }
    }
})

bot.on('guildMemberAdd', (guild, member) => {
    sendWelcome(member);
})

function sendWelcome(user) {
    bot.createMessage("614829461267021850", {
        content: "",
        embed: {
            color: 0x1111FF,
            title: "Welcome, "+user.username+" to GAMESONLINEXD",
            description: "Don't forget to read the rules!"
        }
    })
}

bot.connect();
