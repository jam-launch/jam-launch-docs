
Overview
#############

The goal of Jam Launch is to get your multiplayer game built, tested, and
deployed as quickly as possible. Specifically, it provides:

* **Cloud infrastructure bootstrapping**
    * OpenID-based authentication for players, testers, and developers
    * In-editor game publishing
    * Game distribution and web player hosting
    * Game session provisioning
    * Cloud-based data persistence and querying
* **Pre-built multiplayer components** - the open source example projects and
  addon provide reusable Godot components that can be used to jump-start any
  Godot multiplayer game project. One of the goals for 2024 is to expand these
  into a more comprehensive library.
* **Tight Godot Integration** - Jam Launch game deployments can be seamlessly
  created and monitored from a Godot editor plugin. Godot multiplayer mechanisms
  like RPC and Synchronizer nodes work without any modification.


Motivation and Goals
**********************

Modern game engines and internet infrastructure make it easier than ever to
create immersive multiplayer experiences, but cloud infrastructure and network
configuration continues to hold back many projects. There are many wonderful
guides that explain the many ways that one could go about building their
multiplayer infrastructure from scratch or from a small collection of pre-made
components, but many hobbyists and developer teams simply do not have the time
to research and cobble together a reliable solution - they want something that
will take care of the boring stuff so that they can focus on their game.

This is where Jam Launch comes in - its goal is to provide all of "the boring
stuff" behind a simple abstraction that still gives you control over almost
every aspect of the client and server. Some of the key design goals are:

* **Simplicity** - The simplest use of Jam Launch in a game involves adding a
  single node and connecting one of its signals into your game logic. The
  :doc:`classes provided by the addon<jam-classes/index>` have additional
  features that can be leveraged, but we are determined to keep this as easy as
  possible to adopt.
* **Flexibility** - There is no proprietary protocol or server platform lock-in,
  so projects can be developed and tested in a "vanilla" Godot environment and
  remain largely decoupled from Jam Launch.
* **Capability** - Jam Launch supports competitive, secure, low-latency
  multiplayer. Even the somewhat-simplistic (e.g. no predictive local movement)
  `example game <https://github.com/jam-launch/jam-launch-example>`_ is pretty 
  snappy in the web browser over websockets. We hope to expand the variety of
  supported multiplayer architectures (e.g. peer-to-peer, asynchronous
  competitive multiplayer, etc) over the course of 2024.
* **Value** - Our primary goal with Jam Launch is saving your most precious
  resource, time, *but* we also hope to leverage scale in order to outcompete
  DIY alternatives and save one of your other precious resources, dolla dolla
  bills.


Architecture
*******************

While you don't *need* to understand how Jam Launch works in order to use it,
it's useful to know what is going on "under the hood" so that you can have more
confidence in the technical foundations and maybe even leverage parts of the
public-facing system in your own services (e.g. the OpenID authentication). We
believe that the more you know about how Jam Launch works, the more you will be
convinced of its merits over your other options.

Authentication
===============

Authentication in Jam Launch happens mainly with JSON Web Tokens (a.k.a. JWTs)
that are signed by either AWS Cognito (for the web GUI), or an AWS KMS-based
signing authority in Jam Launch. This provides a proven, open,
cryptographically-sound foundation for developer and player identities, and
enables detailed permission scoping.

While there haven't been any integrations of the sort yet, Jam Launch's use of
an open standard like JWT means that game-related services under your control
could rely on Jam Launch authentication. Similarly, it would not be hard to
integrate an externally-managed JWT identity provider into a Jam Launch game if
you were interested in a "white label" server provisioning system.

Server Provisioning
====================

The specific details of server provisioning in Jam Launch are not very helpful
to document rigorously because they are likely to continue changing and
optimizing in order to get the best value out of each session. However, it's
worth describing the basics of the problem that is being solved.

When you are hosting authoritative multiplayer games in Jam Launch, your server
is running one instance per active session. That means that if there are 50
people playing your game across 12 different games/sessions, there are 12
instances of your server running. There are several goals that Jam Launch aims
to achieve in the process of allocating resources for your servers:

* Get the server up and running quickly after a session is requested
* Get the server running near the players
* Isolate the server so that it only has access to game-specific data and the
  network connection that the peers connect on
* Minimize the cost of running the server while maintaining the required
  performance
* Run the server only for as long as players are connected and playing

Provisioning API
=================

The Jam Launch provisioning API is how a published game that is downloaded by a
player is able to spin up a new session (as described in the previous section)
or join an existing session with a verifiable identity. As one of the primary
interface layers between your game and Jam Launch, it strives to be simple,
secure, and reliable.

The Jam Launch addon provides some helpful wrappers and abstractions for further
simplifying this interface, but the "low-level" calls are just HTTP requests to
REST endpoints that create, join, leave, or read sessions. The "special sauce"
comes from a Jam Launch-issued "Game JWT" (or GJWT) that gives each player's
downloaded copy of their game the ability to interact with this API for *only*
that game as *only* that player.


Developer API and Godot addon
==============================

If it was not already obvious, the goal of Jam Launch is to make developers'
jobs easier. The goal of the developer API and Godot addon is to take this goal
to the next level and enable one-click building, deploying, and log monitoring
from within the Godot editor.

The Developer API allows you to upload your project source to Jam
Launch-maintained build servers that handle multi-platform exports and
access-controlled web publishing.

The :doc:`Jam Launch helper Nodes<jam-classes/index>` provide sensible default
integrations with the Jam Launch APIs, but they are open and malleable to enable
game-specific requirements.


Plans for 2024
***************

Jam Launch is a new platform with some big goals for 2024. In addition to
improving and stabilizing the current offerings, we plan on building out a few
additional major features and resources.

Multiplayer Game Idioms and Bootstrapping
==========================================

Most of the current Jam Launch addon's functionality is fairly specific to Jam
Launch. You could definitely pull useful things out of it, but it isn't the
full-fledged multiplayer game bootstrapping library that it could be. We think
it would be good for both the Godot and Jam Launch ecosystems if we could put
together a great set of tools and documentation that would get more people
building multiplayer games instead of spending all of their time scouring the
befuddling trash magic of the "I want to make a multiplayer game" internet.

Peer-to-peer and Latency-insensitive Solutions
===============================================

We know not everyone is interested in the power or expense of dedicated,
authoritative multiplayer servers. Adding more cost-effective options is a big
priority in 2024, and many of the systems described here will help enable those
improvements.

Customer-focused Improvements
==============================

The best part of building a platform like Jam Launch is working with the
creative folks who find themselves in need of such a platform. While we aim to
be a generic platform that can scale and stabilize for the benefit of all
customers, we are also excited to help tackle immediate customer requirements
and accomodate long-term ideas in our future plans.
